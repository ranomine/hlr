execution
start
	dialogue := dialogueHandler createDialogue.
	dialogue
		onPAbort: [self failure];
		onUAbort: [self failure].

	invoke := dialogue
		requestTcInvokeNamed: self class cancelOperation
		parameters: self parameters
		class: 1 timeout: 500.
	invoke
		onReturnLast: [self success];
		onError: [self failure].
	dialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddress
		originatingAddress: self localSCCPAddress
		applicationContextName: (self class applicationContextFor: self class cancelOperation)