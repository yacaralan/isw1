!classDefinition: #Bill category: 'Zombies'!
DenotativeObject subclass: #Bill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Zombies'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bill class' category: 'Zombies'!
Bill class
	instanceVariableNames: 'energia'!

!Bill class methodsFor: 'getters'!
:59'! !


!Bill class methodsFor: 'acciones' stamp: 's 3/30/2023 19:10:50'!
: 0.5 * second) wait.
	
	LuzAmarilla  prender.
	(Delay for: 0.5 * second) wait.
	LuzAmarilla apagar.
	(Delay for: 0.5 * second) wait.
	
	LuzAmarilla  prender.
	(Delay for: 0.5 * second) wait.
	LuzAmarilla apagar.
	(Delay for: 0.5 * second) wait.
	
	LuzAmarilla  prender.
	(Delay for: 0.5 * second) wait.
	LuzAmarilla apagar.
	(Delay for: 0.5 * second) wait.
	
	LuzAmarilla  prender.
	(Delay for: 0.5 * second) wait.
	LuzAmarilla apagar.
	(Delay for: 0.5 * second) wait.
	! !

!Bill class methodsFor: 'acciones' stamp: 's 3/30/2023 19:06:07'!
ariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'! !

!Bill class methodsFor: 'acciones'!
! !


!Bill class methodsFor: '--** private fileout/in **--' stamp: 's 3/30/2023 20:00:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := 28.! !

Bill initializeAfterFileIn!