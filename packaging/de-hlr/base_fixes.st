Author useAuthor: 'Hacks' during: [
    FreeTypeExternalMemory addInstVarNamed: 'session'.
    FreeTypeExternalMemory compile: 'validate
	(session == Smalltalk session
		and: [ self isValid ]) ifTrue: [ ^self ].
	bytes ifNil: [ ^ self  ].
	session := Smalltalk session.
	self primCopyToExternalMemory: bytes.
	self isValid ifTrue: [ self class register: self ]'
].
Smalltalk snapshot: true andQuit: true.
