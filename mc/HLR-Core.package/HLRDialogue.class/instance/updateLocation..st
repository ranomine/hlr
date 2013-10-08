locationUpdatingPackage
updateLocation: anInvocation
	<consumer: 'VLR'>
	<package: 'locationUpdatingPackage-v3'>

	| imsi mscNumber vlrNumber |

	imsi := GSMNumberDigits decodeFrom: (ByteArray readHexFrom: anInvocation argument imsi).
	mscNumber := nil.
	vlrNumber := nil.

	(HLRUpdateLocationOperation for: imsi)
		mscNumber: mscNumber;
		vlrNumber: vlrNumber;
		database: hlr database;
		dialogue: self;
		invocation: anInvocation;
		execute.