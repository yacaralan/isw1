!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'LMR 6/4/2023 18:56:37'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'LMR 6/4/2023 18:56:36'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'LMR 6/4/2023 23:44:06'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	observer := Observer new.! !


!MarsRover methodsFor: 'heading' stamp: 'LMR 6/5/2023 00:29:56'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	observer updateHeading: 'Apuntando al Este'.! !

!MarsRover methodsFor: 'heading' stamp: 'LMR 6/5/2023 00:30:07'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	observer updateHeading: 'Apuntando al Norte'.! !

!MarsRover methodsFor: 'heading' stamp: 'LMR 6/5/2023 00:30:16'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	observer updateHeading: 'Apuntando al Sur'.! !

!MarsRover methodsFor: 'heading' stamp: 'LMR 6/5/2023 00:30:23'!
headWest
	
	head := MarsRoverHeadingWest for: self.
	observer updateHeading: 'Apuntando al Oeste'.! !

!MarsRover methodsFor: 'heading' stamp: 'LMR 6/4/2023 20:32:00'!
rotateLeft
	
	head rotateLeft.! !

!MarsRover methodsFor: 'heading' stamp: 'LMR 6/4/2023 20:31:57'!
rotateRight
	
	head rotateRight.! !


!MarsRover methodsFor: 'testing' stamp: 'LMR 6/4/2023 18:56:37'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'LMR 6/4/2023 18:56:37'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'LMR 6/4/2023 18:56:36'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'LMR 6/4/2023 18:56:36'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'LMR 6/4/2023 18:56:37'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'LMR 6/4/2023 23:45:28'!
moveBackward
	
	head moveBackward.
	observer updatePosition: position.! !

!MarsRover methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:37'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'LMR 6/4/2023 23:46:35'!
moveForward
	
	head moveForward.
	observer updatePosition: position.! !

!MarsRover methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:36'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:36'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:36'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'LMR 6/4/2023 18:56:36'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'LMR 6/4/2023 18:56:36'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observer' stamp: 'LMR 6/5/2023 00:32:57'!
observer

	^observer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'LMR 6/4/2023 18:56:37'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverEventListener category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverEventListener
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverEventListener methodsFor: 'showing' stamp: 'LMR 6/4/2023 23:56:09'!
show

	self subclassResponsibility.! !


!MarsRoverEventListener methodsFor: 'updating' stamp: 'LMR 6/5/2023 00:00:30'!
update: roverInfo

	self subclassResponsibility.! !


!MarsRoverEventListener methodsFor: 'initialization' stamp: 'LMR 6/4/2023 23:56:13'!
initialize

	self subclassResponsibility.! !


!classDefinition: #Logger category: 'MarsRover-WithHeading'!
MarsRoverEventListener subclass: #Logger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'showing' stamp: 'LMR 6/4/2023 21:08:11'!
show
	
	^log! !


!Logger methodsFor: 'updating' stamp: 'LMR 6/5/2023 00:00:37'!
update: roverInfo

	log add: roverInfo.! !


!Logger methodsFor: 'initialization' stamp: 'LMR 6/4/2023 21:24:53'!
initialize

	log := OrderedCollection new.! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
MarsRoverEventListener subclass: #Window
	instanceVariableNames: 'window'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'initialization' stamp: 'LMR 6/4/2023 18:56:39'!
initialize

	window := 'nada'.! !


!Window methodsFor: 'updating' stamp: 'LMR 6/5/2023 00:00:43'!
update: roverInfo 
	
	window := roverInfo.! !


!Window methodsFor: 'showing' stamp: 'LMR 6/4/2023 21:09:17'!
show
	
	^window.! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:37'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:37'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'LMR 6/4/2023 18:56:37'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:37'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:37'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'LMR 6/4/2023 18:56:37'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'LMR 6/4/2023 18:56:37'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:37'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:37'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:37'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:37'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:38'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:37'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:37'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:37'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:38'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:38'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:38'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:38'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:38'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'LMR 6/4/2023 18:56:38'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:38'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'LMR 6/4/2023 18:56:38'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #Observer category: 'MarsRover-WithHeading'!
Object subclass: #Observer
	instanceVariableNames: 'listeners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Observer methodsFor: 'initialization' stamp: 'LMR 6/5/2023 00:09:52'!
initialize

	listeners := Dictionary new.! !


!Observer methodsFor: 'updating' stamp: 'LMR 6/5/2023 00:17:11'!
updateHeading: aHeading

	listeners at: 'heading' ifPresent: [:headingListeners | 
		headingListeners do: [:listener | listener update: aHeading].
		].! !

!Observer methodsFor: 'updating' stamp: 'LMR 6/5/2023 00:16:01'!
updatePosition: aPosition

	listeners at: 'position' ifPresent: [:positionListeners | 
		positionListeners do: [:listener | listener update: aPosition].
		].! !


!Observer methodsFor: 'add listener' stamp: 'LMR 6/5/2023 00:26:15'!
addListener: anEventListener subscribedTo: subscriptions

	subscriptions do: [:aSubscription | 
		listeners at: aSubscription 
		ifPresent: [:subscribedListeners | subscribedListeners add: anEventListener] 
		ifAbsent: [listeners at: aSubscription put: (Set with: anEventListener)]
		]! !
!classDefinition: #LogTest category: 'MarsRover-WithHeading-Tests'!
TestCase subclass: #LogTest
	instanceVariableNames: 'positionSubscription headingSubscription bothSubscription mrAt1At1HeadingNorth mrObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading-Tests'!

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:41:28'!
test01StartingMarsRoverHasEmptyLog
	
	| positionLogger|
	positionLogger := Logger new.
	mrObserver addListener: positionLogger subscribedTo: positionSubscription.
	
	mrAt1At1HeadingNorth process: ''.
	self assert: positionLogger show isEmpty.! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:41:44'!
test02StartingMarsRoverHasEmptyWindow
	
	| positionWindow |
	positionWindow := Window new.
	mrObserver addListener: positionWindow subscribedTo: positionSubscription.
	
	mrAt1At1HeadingNorth process: ''.
	self assert: positionWindow show equals: 'nada'.! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:41:56'!
test03PositionLoggerOfRoverRegistersMovement
	
	| positionLogger expected |
	positionLogger := Logger new.
	mrObserver addListener: positionLogger subscribedTo: positionSubscription.
	
	mrAt1At1HeadingNorth process: 'f'.
	expected := OrderedCollection with: 1@2.
	self assert: expected equals: positionLogger show.! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:42:10'!
test04PositionWindowOfRoverHasLastPosition
	
	| positionWindow |
	positionWindow := Window new.
	mrObserver addListener: positionWindow subscribedTo: positionSubscription.
	
	mrAt1At1HeadingNorth process: 'f'.
	self assert: 1@2 equals: positionWindow show.! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:42:24'!
test05PositionLoggerOfRoverRegistersManyMovements
	
	| positionLogger expected |
	positionLogger := Logger new.
	mrObserver addListener: positionLogger subscribedTo: positionSubscription.
	
	mrAt1At1HeadingNorth process: 'ffbf'.
	expected := OrderedCollection with: 1@2 with: 1@3 with: 1@2 with: 1@3.
	self assert: expected equals: positionLogger show.! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:42:41'!
test06PositionLoggerAndWindowOfRoverWorkAtTheSameTime
	
	| positionLogger positionWindow expected |
	positionLogger := Logger new.	
	positionWindow := Window new.
	mrObserver addListener: positionLogger subscribedTo: positionSubscription.
	mrObserver addListener: positionWindow subscribedTo: positionSubscription.
	
	mrAt1At1HeadingNorth process: 'f'.
	expected := OrderedCollection with: 1@2.
	self assert: expected equals: positionLogger show.
	self assert: 1@2 equals: positionWindow show.! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:43:42'!
test07HeadingLoggerOfNewRoverHasEmptyLog
	
	| headingLogger |
	headingLogger := Logger new.	
	mrObserver addListener: headingLogger subscribedTo: headingSubscription.
	
	mrAt1At1HeadingNorth process: ''.
	self assert: headingLogger show isEmpty.
	! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:46:49'!
test08HeadingWindowOfNewRoverIsEmpty
	
	| headingWindow |
	headingWindow := Window new.	
	mrObserver addListener: headingWindow subscribedTo: headingSubscription.
	
	mrAt1At1HeadingNorth process: ''.
	self assert: headingWindow show equals: 'nada'.
	! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:46:51'!
test09HeadingLoggerOfRoverRegistersARotation
	
	| headingLogger expected |
	headingLogger := Logger new.	
	mrObserver addListener: headingLogger subscribedTo: headingSubscription.
	
	mrAt1At1HeadingNorth process: 'r'.
	expected := OrderedCollection with: 'Apuntando al Este'.
	self assert: expected equals: headingLogger show.
	! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:46:54'!
test10HeadingWindowOfRoverRegistersLastHeading
	
	| headingWindow expected |
	headingWindow := Window new.	
	mrObserver addListener: headingWindow subscribedTo: headingSubscription.
	
	mrAt1At1HeadingNorth process: 'r'.
	expected := 'Apuntando al Este'.
	self assert: expected equals: headingWindow show.
	! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:46:57'!
test11HeadingLoggerOfRoverRegistersManyRotations
	
	| headingLogger expected |
	headingLogger := Logger new.	
	mrObserver addListener: headingLogger subscribedTo: headingSubscription.
	
	mrAt1At1HeadingNorth process: 'rlll'.
	expected := OrderedCollection with: 'Apuntando al Este' with: 'Apuntando al Norte' with: 'Apuntando al Oeste' with: 'Apuntando al Sur'.
	self assert: expected equals: headingLogger show.
	! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:47:01'!
test12MarsRoverCanHaveMultipleHeadingLoggers
	
	| headingLogger headingWindow expected |
	headingLogger := Logger new.	
	headingWindow := Window new.	
	mrObserver addListener: headingWindow subscribedTo: headingSubscription.
	mrObserver addListener: headingLogger subscribedTo: headingSubscription.
	
	mrAt1At1HeadingNorth process: 'rlll'.
	expected := OrderedCollection with: 'Apuntando al Este' with: 'Apuntando al Norte' with: 'Apuntando al Oeste' with: 'Apuntando al Sur'.
	self assert: expected equals: headingLogger show.
	self assert: 'Apuntando al Sur' equals: headingWindow show.
	! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:46:00'!
test13LoggerCanLogPositionAndHeading
	
	| bothLogger expected |
	bothLogger := Logger new.
	mrObserver addListener: bothLogger subscribedTo: bothSubscription.
	
	mrAt1At1HeadingNorth process: 'frlllf'.
	expected := OrderedCollection with: 1@2 with: 'Apuntando al Este' with: 'Apuntando al Norte' with: 'Apuntando al Oeste' with: 'Apuntando al Sur' with: 1@1.
	self assert: expected equals: bothLogger show.
	! !

!LogTest methodsFor: 'tests' stamp: 'LMR 6/5/2023 00:47:07'!
test14WindowRegisterBothPositionAndHeading
	
	| bothWindow expected |
	bothWindow := Window new.	
	mrObserver addListener: bothWindow subscribedTo: bothSubscription.
	
	mrAt1At1HeadingNorth process: 'frlllf'.
	expected := 1@1.
	self assert: expected equals: bothWindow show.
	mrAt1At1HeadingNorth process: 'lfl'.
	expected := 'Apuntando al Norte'.
	self assert: expected equals: bothWindow show.
	! !


!LogTest methodsFor: 'setUp/tearDown' stamp: 'LMR 6/5/2023 00:40:52'!
setUp

	mrAt1At1HeadingNorth := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	mrObserver := mrAt1At1HeadingNorth observer.
	positionSubscription := Set with: 'position'.
	headingSubscription := Set with: 'heading'.
	bothSubscription := Set with: 'position' with: 'heading'.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading-Tests'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading-Tests'!

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:39'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:39'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:38'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LMR 6/4/2023 18:56:39'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'LMR 6/4/2023 18:56:38'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'LMR 6/4/2023 18:56:39'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'LMR 6/4/2023 18:56:39'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'LMR 6/4/2023 18:56:38'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'LMR 6/4/2023 18:56:39'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !
