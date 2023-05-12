!classDefinition: #MarsRoverTDD category: 'MarsRoverEjercicio'!
TestCase subclass: #MarsRoverTDD
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverTDD methodsFor: 'as yet unclassified' stamp: 'AYac 5/11/2023 21:27:43'!
assertThat: aMarsRover isInLocation: aCoordinate facing: aCardinal
	
	self assert: aCoordinate equals: aMarsRover location.
	self assert: aCardinal equals: aMarsRover direction! !

!MarsRoverTDD methodsFor: 'as yet unclassified' stamp: 'AYac 5/11/2023 21:32:27'!
test01EmpiezaEnLaCordenadaYDireccionInicial

	 | marsRover |
	marsRover := MarsRover newAt: 2@2 facing: #North.
	
	self assertThat: marsRover isInLocation: 2@2 facing: #North ! !

!MarsRoverTDD methodsFor: 'as yet unclassified' stamp: 'AYac 5/11/2023 21:38:18'!
test02LeerComandoVacioNoHaceNada

	 | marsRover |
	marsRover := MarsRover newAt: 2@2 facing: #North.
	
	marsRover readComands: ''.
	
	self assertThat: marsRover isInLocation: 2@2 facing: #North ! !


!classDefinition: #MarsRover category: 'MarsRoverEjercicio'!
Object subclass: #MarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRover methodsFor: 'category-name' stamp: 'AYac 5/11/2023 21:08:26'!
direction
	
	^#North! !

!MarsRover methodsFor: 'category-name' stamp: 'AYac 5/11/2023 20:52:41'!
location
	
	^ 2@2! !

!MarsRover methodsFor: 'category-name' stamp: 'AYac 5/11/2023 21:38:59'!
readComands: aStringOfCommands 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverEjercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AYac 5/11/2023 20:52:12'!
newAt: aCoordinate 
	^self new ! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AYac 5/11/2023 21:08:01'!
newAt: aPoint facing: aCardinal 

	^self new! !
