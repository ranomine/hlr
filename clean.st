World closeAllWindowsDiscardingChanges.
EpMonitor current disable.
(RPackage organizer packages select: [:package | package packageName includesSubstring: 'Test'])
	do: [:each | each removeFromSystem ].
(RPackage organizer packages select: [:package | package packageName beginsWith: 'Versionner'])
	do: [:each | each removeFromSystem ].
(RPackage organizer packages select: [:package | package packageName beginsWith: 'ProfStef'])
	do: [:each | each removeFromSystem ].
(RPackage organizer packages select: [:package | package packageName beginsWith: 'Ice'])
	do: [:each | each removeFromSystem ].
(RPackage organizer packages select: [:package | package packageName beginsWith: 'BaselineOf'])
	do: [:each | each removeFromSystem ].
(RPackage organizer packages select: [:package | package packageName beginsWith: 'ConfigurationOf'])
	do: [:each | each removeFromSystem ].
(RPackage organizer packages select: [:package | package packageName endsWith: '-Help'])
	do: [:each | each removeFromSystem ].
(RPackage organizer packages select: [:package | package packageName endsWith: 'Examples'])
	do: [:each | each removeFromSystem ].

ImageCleaner new cleanUpForRelease.
Smalltalk snapshot: true andQuit: true.
