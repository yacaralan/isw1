!classDefinition: #MarsRoverTDD category: 'MarsRoverEjercicio'!
TestCase subclass: #MarsRoverTDD
	instanceVariableNames: 'roverStartingAt2x2facingNorth roverStartingAt2x2facingWest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:25:11'!
test01EmpiezaEnLaCordenadaYDireccionInicial
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@2 facing: North new! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:25:11'!
test02LeerComandoVacioNoHaceNada

	roverStartingAt2x2facingNorth executeCommand: ''.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@2 facing: North new! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:25:11'!
test03Leer1ComandoFMirandoUnaDireccion
	
	roverStartingAt2x2facingNorth executeCommand: 'f'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@3 facing: North new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:29:51'!
test04Leer1ComandoFMirandoCualquierCardinal

	roverStartingAt2x2facingWest executeCommand: 'f'.
	
	self assertThat: roverStartingAt2x2facingWest isInLocation: 1@2 facing: West new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:26:05'!
test05Leer1ComandoBMirandoCualquierCardinal

	roverStartingAt2x2facingNorth executeCommand: 'b'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@1 facing: North new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:26:30'!
test06Leer1ComandoLMirandoUnCardinal
	
	roverStartingAt2x2facingNorth executeCommand: 'l'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@2 facing: West new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:30:03'!
test07Leer1ComandoLMirandoCualquierCardinal

	roverStartingAt2x2facingWest executeCommand: 'l'.
	
	self assertThat: roverStartingAt2x2facingWest isInLocation: 2@2 facing: South new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:30:14'!
test08Leer1ComandoRMirandoCualquierCardinal

	roverStartingAt2x2facingWest executeCommand: 'r'.
	
	self assertThat: roverStartingAt2x2facingWest isInLocation: 2@2 facing: North new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:26:54'!
test09LeerMultiplesComandosMirandoUnCardinal
	
	roverStartingAt2x2facingNorth executeCommand: 'fff'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@5 facing: North new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:27:12'!
test10LeerMultiplesComandosMirandoCualquierCardinal
	
	roverStartingAt2x2facingNorth executeCommand: 'frf'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 3@3 facing: East new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:28:23'!
test11TrasLeerComandoInvalidoIgnoraTodoLoDemas

	roverStartingAt2x2facingNorth executeCommand: 'fffgfff'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@5 facing: North new ! !


!MarsRoverTDD methodsFor: 'set up' stamp: 'a 5/12/2023 01:29:06'!
setUp

	roverStartingAt2x2facingNorth := MarsRover newAt: 2@2 facing: North.
	roverStartingAt2x2facingWest := MarsRover newAt: 2@2 facing: West.
	
	! !


!MarsRoverTDD methodsFor: 'custom assertions' stamp: 'a 5/12/2023 00:04:43'!
assertThat: aMarsRover isInLocation: aCoordinate facing: aCardinal
	
	self assert: aCoordinate equals: aMarsRover location.
	self assert: (aCardinal isKindOf: aMarsRover direction class)! !


!classDefinition: #Cardinales category: 'MarsRoverEjercicio'!
Object subclass: #Cardinales
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!Cardinales methodsFor: 'commands' stamp: 'a 5/12/2023 01:08:58'!
executeCommand: aCommand

	self subclassResponsibility ! !


!Cardinales methodsFor: 'initialization' stamp: 'a 5/12/2023 00:02:56'!
initializeOf: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cardinales class' category: 'MarsRoverEjercicio'!
Cardinales class
	instanceVariableNames: ''!

!Cardinales class methodsFor: 'instance creation' stamp: 'a 5/12/2023 00:02:35'!
of: aMarsRover 

	^self new initializeOf: aMarsRover ! !


!classDefinition: #East category: 'MarsRoverEjercicio'!
Cardinales subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!East methodsFor: 'commands' stamp: 'a 5/12/2023 01:08:27'!
executeCommand: aCommand 

	aCommand = $f ifTrue: [marsRover increaseX].
	aCommand = $b ifTrue: [marsRover decreaseX].
	aCommand = $l ifTrue: [marsRover face: North].
	aCommand = $r ifTrue: [marsRover face: South]
	
	! !


!classDefinition: #North category: 'MarsRoverEjercicio'!
Cardinales subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!North methodsFor: 'commands' stamp: 'a 5/12/2023 01:08:11'!
executeCommand: aCommand 

	aCommand = $f ifTrue: [marsRover increaseY].
	aCommand = $b ifTrue: [marsRover decreaseY].
	aCommand = $l ifTrue: [marsRover face: West].
	aCommand = $r ifTrue: [marsRover face: East]
	! !


!classDefinition: #South category: 'MarsRoverEjercicio'!
Cardinales subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!South methodsFor: 'commands' stamp: 'a 5/12/2023 01:34:27'!
executeCommand: aCommand 
	
	aCommand = $f ifTrue: [marsRover decreaseY].
	aCommand = $b ifTrue: [marsRover increaseY].
	aCommand = $l ifTrue: [marsRover face: East].
	aCommand = $r ifTrue: [marsRover face: West]
	! !


!classDefinition: #West category: 'MarsRoverEjercicio'!
Cardinales subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!West methodsFor: 'commands' stamp: 'a 5/12/2023 01:35:37'!
executeCommand: aCommand 

	aCommand = $f ifTrue: [marsRover decreaseX].
	aCommand = $b ifTrue: [marsRover increaseX].
	aCommand = $l ifTrue: [marsRover face: South].
	aCommand = $r ifTrue: [marsRover face: North]! !


!classDefinition: #MarsRover category: 'MarsRoverEjercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'location cardinal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRover methodsFor: 'initialization' stamp: 'a 5/12/2023 00:01:37'!
initializeAt: aCoordinate facing: aCardinal 
	
	location := aCoordinate.
	cardinal := aCardinal of: self.! !


!MarsRover methodsFor: 'commands' stamp: 'a 5/12/2023 01:19:53'!
executeCommand: aStringOfCommands 

	aStringOfCommands do: [:aCommand| 
		(self isValidCommand: aCommand) ifFalse: [^self].
		cardinal executeCommand: aCommand]
	! !


!MarsRover methodsFor: 'aux movements' stamp: 'a 5/12/2023 00:57:32'!
decreaseX
	
	location := location - (1@0)! !

!MarsRover methodsFor: 'aux movements' stamp: 'a 5/12/2023 00:52:05'!
decreaseY
	
	location := location - (0@1)! !

!MarsRover methodsFor: 'aux movements' stamp: 'a 5/12/2023 00:34:58'!
face: aCardinal
	
	cardinal := aCardinal of: self! !

!MarsRover methodsFor: 'aux movements' stamp: 'a 5/12/2023 00:57:48'!
increaseX
	
	location := location + (1@0)! !

!MarsRover methodsFor: 'aux movements' stamp: 'a 5/12/2023 00:52:10'!
increaseY
	
	location := location + (0@1)! !


!MarsRover methodsFor: 'testing' stamp: 'a 5/11/2023 23:47:48'!
direction
	
	^ cardinal ! !

!MarsRover methodsFor: 'testing' stamp: 'a 5/12/2023 01:19:39'!
isValidCommand: aCommand 
	
	^'fbrl' includes: aCommand ! !

!MarsRover methodsFor: 'testing' stamp: 'a 5/11/2023 23:32:06'!
location
	
	^ location! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverEjercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'a 5/11/2023 23:33:29'!
newAt: aCoordinate facing: aCardinal 

	^self new initializeAt: aCoordinate facing: aCardinal! !
