shortMsgGatewayPackage
sendRoutingInfoForSMV3: anInvocation
	<consumer: 'GMSC'>
	<package: 'shortMsgGatewayPackage-v3'>

	| msisdn smscAddr cdr |
	msisdn := anInvocation argument msisdn fromE164.
	smscAddr := anInvocation argument serviceCentreAddress fromE164.
	logger logDebug: 'sendRoutingInfoForSMv3' with: { 'msisdn' -> msisdn. 'smscAddr' -> smscAddr }.
	cdr := hlr cdrClient sendRoutingInfo: msisdn smscAddr: smscAddr dialogue: self.

	self sendRoutingInfoForSMOperationV3Class new
		originatingCallDataRecord: cdr;		
		hlr: hlr;
		dialogue: self;
		invocation: anInvocation;
		msisdn: msisdn;
		smscAddr: smscAddr;
		highPriority: anInvocation argument sm_RP_PRI;
		execute