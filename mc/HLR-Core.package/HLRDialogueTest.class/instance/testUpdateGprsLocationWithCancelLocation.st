test-locationUpdatingPackage
testUpdateGprsLocationWithCancelLocation
	| operationName dialogue invoke res invoked param receivedCancel operation |
	invoked := 0.
	operationName := 'updateGprsLocation'.
	dialogue := testEndPoint newDialogue.
	operation := self rosOperationNamed: operationName.
	param := operation newArgumentValue 
		at: 'imsi' put: subscriber imsiAsTBCD;
		at: 'sgsn-Number' put: '9123' byteArrayFromHex;
		at: 'sgsn-Address' put: #[4 0 0 0 0];
		yourself.
	(param expandFieldNamed: 'sgsn-Capability')
		at: 'gprsEnhancementsSupportIndicator' put: nil.
		
	subscriber
		sgsnNumber: '91555555'.

	receivedCancel := false.

	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:invocation |
				receivedCancel := true.
				invocation returnResultLast: nil.
				diag requestTcEnd: false]].

	dialogue
		onInvoke: [ :insert |
			invoked  := invoked + 1.
			insert returnResultLast: nil.
			dialogue requestTcContinue].

	invoke := dialogue requestTcInvoke: operation parameters:  param class: 1 timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [:result | res := true ].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).

	self assert: res.
	self assert: invoked = 1.
	self assert: subscriber sgsnNumber = '32'.
	self assert: receivedCancel.