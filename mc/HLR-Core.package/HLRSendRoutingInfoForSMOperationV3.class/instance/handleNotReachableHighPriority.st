as yet unclassified
handleNotReachableHighPriority
	| param |

	"This is still a mess. I think we need to report the old msc-Number"
	subscriber addToMessageWaitingList: smscAddr.
	hlr database updateSubscriber: subscriber.

	"Now 'ACK' the request.. do that with the old msc-Number?"
	invocation returnResultLast: nil.

	"Tell the GSMSC that we have now queued this SMSC. It a unconfirmed service"
	param := ASN1Dictionary new
		at: 'mw-Status' put: '0100';
		yourself.
	dialogue requestTcInvokeNamed: 'informServiceCentreV3' parameters:  param class: 1 timeout: 500.
	
	"Send the two invocations and be done"
	dialogue requestTcEnd: false.