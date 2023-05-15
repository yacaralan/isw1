!classDefinition: #MarsRoverTDD category: 'MarsRoverEjercicio'!
TestCase subclass: #MarsRoverTDD
	instanceVariableNames: 'roverStartingAt2x2facingNorth roverStartingAt2x2facingWest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverTDD methodsFor: 'tests' stamp: 'a 5/12/2023 01:25:11'!
test01EmpiezaEnLaCordenadaYDireccionInicial
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@2 facing: North new! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test02LeerComandoVacioNoHaceNada

	roverStartingAt2x2facingNorth executeCommands: ''.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@2 facing: North new! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test03Leer1ComandoFMirandoUnaDireccion
	
	roverStartingAt2x2facingNorth executeCommands: 'f'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@3 facing: North new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test04Leer1ComandoFMirandoCualquierCardinal

	roverStartingAt2x2facingWest executeCommands: 'f'.
	
	self assertThat: roverStartingAt2x2facingWest isInLocation: 1@2 facing: West new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test05Leer1ComandoBMirandoCualquierCardinal

	roverStartingAt2x2facingNorth executeCommands: 'b'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@1 facing: North new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test06Leer1ComandoLMirandoUnCardinal
	
	roverStartingAt2x2facingNorth executeCommands: 'l'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@2 facing: West new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test07Leer1ComandoLMirandoCualquierCardinal

	roverStartingAt2x2facingWest executeCommands: 'l'.
	
	self assertThat: roverStartingAt2x2facingWest isInLocation: 2@2 facing: South new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test08Leer1ComandoRMirandoCualquierCardinal

	roverStartingAt2x2facingWest executeCommands: 'r'.
	
	self assertThat: roverStartingAt2x2facingWest isInLocation: 2@2 facing: North new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test09LeerMultiplesComandosMirandoUnCardinal
	
	roverStartingAt2x2facingNorth executeCommands: 'fff'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@5 facing: North new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test10LeerMultiplesComandosMirandoCualquierCardinal
	
	roverStartingAt2x2facingNorth executeCommands: 'frf'.
	
	self assertThat: roverStartingAt2x2facingNorth isInLocation: 3@3 facing: East new ! !

!MarsRoverTDD methodsFor: 'tests' stamp: 'LMR 5/15/2023 17:51:27'!
test11TrasLeerComandoInvalidoIgnoraTodoLoDemas

	self
		should: [roverStartingAt2x2facingNorth executeCommands: 'fffgfff'.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: MarsRover invalidCommandErrorDescription .
			self assertThat: roverStartingAt2x2facingNorth isInLocation: 2@5 facing: North new]! !


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

!Cardinales methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:06:52'!
moveBackward

	self subclassResponsibility ! !

!Cardinales methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:06:45'!
moveForward

	self subclassResponsibility ! !

!Cardinales methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:06:58'!
rotateLeft

	self subclassResponsibility ! !

!Cardinales methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:07:02'!
rotateRight

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

!East methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:00:00'!
moveBackward

	marsRover decreaseX

	
	! !

!East methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:00:20'!
moveForward

	marsRover increaseX

	
	! !

!East methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:00:33'!
rotateLeft

	marsRover face: North
	
	! !

!East methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:00:47'!
rotateRight

	marsRover face: South
	
	! !


!classDefinition: #North category: 'MarsRoverEjercicio'!
Cardinales subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!North methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:02:01'!
moveBackward

	marsRover decreaseY! !

!North methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:02:09'!
moveForward

	marsRover increaseY! !

!North methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:02:20'!
rotateLeft

	marsRover face: West! !

!North methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:02:27'!
rotateRight

	marsRover face: East
	! !


!classDefinition: #South category: 'MarsRoverEjercicio'!
Cardinales subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!South methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:04:30'!
moveBackward
	
	marsRover increaseY! !

!South methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:04:20'!
moveForward
	
	marsRover decreaseY
	! !

!South methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:04:11'!
rotateLeft
	
	marsRover face: East
	! !

!South methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:04:01'!
rotateRight
	
	marsRover face: West
	! !


!classDefinition: #West category: 'MarsRoverEjercicio'!
Cardinales subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!West methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:06:15'!
moveBackward

	marsRover increaseX! !

!West methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:06:23'!
moveForward

	marsRover decreaseX! !

!West methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:05:44'!
rotateLeft

	marsRover face: South! !

!West methodsFor: 'movements' stamp: 'LMR 5/15/2023 18:06:03'!
rotateRight

	marsRover face: North! !


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


!MarsRover methodsFor: 'commands' stamp: 'LMR 5/15/2023 17:58:15'!
executeCommand: aCommand 
	
	(self isValidCommand: aCommand) ifFalse: [^self error: self class invalidCommandErrorDescription ].
	aCommand = $f ifTrue: [cardinal moveForward].
	aCommand = $b ifTrue: [cardinal moveBackward].
	aCommand = $l ifTrue: [cardinal rotateLeft].
	aCommand = $r ifTrue: [cardinal rotateRight]	.
	
	! !

!MarsRover methodsFor: 'commands' stamp: 'LMR 5/15/2023 17:57:46'!
executeCommands: aStringOfCommands 

	aStringOfCommands do: [:aCommand| self executeCommand: aCommand]
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

!MarsRover class methodsFor: 'error description' stamp: 'LMR 5/15/2023 16:55:53'!
invalidCommandErrorDescription

	^'Comando no valido'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'a 5/11/2023 23:33:29'!
newAt: aCoordinate facing: aCardinal 

	^self new initializeAt: aCoordinate facing: aCardinal! !
