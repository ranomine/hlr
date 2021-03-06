infoRetrievalPackage
sendAuthenticationInfoV3: anInvocation
	<consumer: 'VLR'>
	<consumer: 'HLR'>
	<package: 'infoRetrievalPackage-v3'>

	| imsi vectors isSGSN |
	imsi := anInvocation argument imsi fromTBCD.
	vectors := anInvocation argument numberOfRequestedVectors.
	isSGSN := anInvocation argument requestingNodeType value = 'sgsn'.
	logger logDebug: 'sendAuthenticationInfoV3' with: { 'imsi' -> imsi. 'isSGSN' -> isSGSN. 'vectors' -> vectors }.
	vectors ifNil: [vectors := 4].
	
	(HLRSendAuthenticationInfoOperationV3 for: imsi)
		vectors: vectors;
		hlr: hlr;
		dialogue: self;
		invocation: anInvocation;
		execute.