Author useAuthor: 'RHHack' during: [
    "Fix up some MongoTalk deficits for OrderedCollection"
    Smalltalk at: #OrderedDictionary ifPresent: [:dictClass |
        dictClass compile: 'writeBSONOn: aBSON
    aBSON nextOrderedDictionaryPut: self'.
        dictClass compile: 'bsonTypeCode
    ^3'.
        dictClass compile: 'asMongoQuery
    ^self'
    ].

    "Code rewrite + logging"
    Smalltalk version = 'Pharo6.0' ifTrue: [
        Deprecation compile: 'transform
'.
        SmalltalkImage compile: 'logDuring: aMonadicBlock
"Skip for now. Transcript is enough and two outputs look bad
    aMonadicBlock value: RHStdoutWrapper wrapStdout."'.

       "Add what can be achieved with --no-source in the future"
       CodeImporter compile: 'flushChangesFile
       '.
       DoItChunk compile: 'importFor: requestor
       
       (contents beginsWith: ''----'') ifTrue: [ ^self ].
       
       self flag: #fixme. "Ugly hack to parse preamble and postcript as a do it."
       ((contents beginsWith: ''"Change Set:'') and: [ ChangeSet current preambleString isNil ])
           ifTrue: [ ChangeSet current preambleString: contents ].
       ((contents beginsWith: ''"Postscript:'') and: [ ChangeSet current postscriptString isNil ])
           ifTrue: [ ChangeSet current postscriptString: contents ].

       ^Smalltalk compiler class new
           source: contents;
           requestor: requestor;
           logged: false;
           evaluate.'
    ].

    "Yield the CPU for longer.. reducing the idle load..."
    ProcessorScheduler class compile: 'idleProcess
    "A default background process which is invisible."

    [true] whileTrue:
        [self relinquishProcessorForMicroseconds: 80000]'.

    "Disable Nagle for the Mongo connections. Don't wait for the TCP DACK before sending
    the getLastError."
    Mongo compile: 'open
	stream := GratuitousIncompatibilities socketStreamHost: host port: port.
	stream socket setOption: ''TCP_NODELAY'' value: 1.
	authCache := nil'
].


"Now leave but in a new process to let other things die"
[
  Smalltalk garbageCollect; garbageCollect.
  Smalltalk snapshot: true andQuit: true
] newProcess
    name: 'Fix Process';
    resume.
