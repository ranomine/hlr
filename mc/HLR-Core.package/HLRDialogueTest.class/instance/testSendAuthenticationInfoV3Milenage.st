tests-infoRetrievalPackage
testSendAuthenticationInfoV3Milenage
	| operationName dialogue invoke invokeResponse operation param |

	subscriber credentials: (SubscriberMilenageCredentials new
		sqn: 16rFFFFFFFFFFFE;
		opc: (ByteArray new: 16);
		ki: (ByteArray new: 16);
		yourself).
	self assert: subscriber credentials sqn equals: 16rFFFFFFFFFFFE.

	operationName := 'sendAuthenticationInfoV3'.
	dialogue := testEndPoint newDialogue.
	operation := dialogue rosOperationNamed: operationName.
	param := operation newArgumentValue.
	invoke := dialogue requestTcInvokeNamed: operationName parameters: (self createAuthV3ParamsOn: param) class: 1 timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [:result | invokeResponse := result resultObject authenticationSetList quintupletList ].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
		

	self assert: invokeResponse size = 1.
	self assert: subscriber credentials sqn equals: 16rFFFFFFFFFFFF.

	subscriber credentials incrementSqn.
	self assert: subscriber credentials sqn equals: 32.	