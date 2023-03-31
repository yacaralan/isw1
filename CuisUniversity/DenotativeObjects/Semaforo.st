!classDefinition: #LuzAmarilla category: 'Semaforo'!
DenotativeObject subclass: #LuzAmarilla
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzAmarilla class' category: 'Semaforo'!
LuzAmarilla class
	instanceVariableNames: 'color'!

!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 's 3/30/2023 19:00:48'!
apagar
	color := Color black! !

!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 's 3/30/2023 19:00:40'!
prender
	color := Color yellow! !


!LuzAmarilla class methodsFor: '--** private fileout/in **--' stamp: 's 3/30/2023 21:57:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	color := nil.! !


!classDefinition: #LuzRoja category: 'Semaforo'!
DenotativeObject subclass: #LuzRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!


!classDefinition: #LuzVerde category: 'Semaforo'!
DenotativeObject subclass: #LuzVerde
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!


!classDefinition: #SemaforoDeMaipuYCorrientes category: 'Semaforo'!
DenotativeObject subclass: #SemaforoDeMaipuYCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeMaipuYCorrientes class' category: 'Semaforo'!
SemaforoDeMaipuYCorrientes class
	instanceVariableNames: 'LuzVerde LuzAmarilla LuzRoja Temporizador ControladorDeSemaforo'!

!SemaforoDeMaipuYCorrientes class methodsFor: 'metodos' stamp: 's 3/30/2023 19:35:46'!
avisarPrecaucionDeEncendido

	5 timesRepeat: [self titilarLuzAmarilla]! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'metodos' stamp: 's 3/30/2023 19:33:54'!
prender
	
	self avisarPrecaucionDeEncendido.
	! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'metodos' stamp: 's 3/30/2023 19:30:26'!
titilarLuzAmarilla

	LuzAmarilla  prender.
	(Delay for: 0.5 * second) wait.
	LuzAmarilla apagar.
	(Delay for: 0.5 * second) wait! !


!SemaforoDeMaipuYCorrientes class methodsFor: '--** private fileout/in **--' stamp: 's 3/30/2023 21:57:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	LuzVerde := nil.
	LuzAmarilla := nil.
	LuzRoja := nil.
	Temporizador := nil.
	ControladorDeSemaforo := nil.! !

LuzAmarilla initializeAfterFileIn!
SemaforoDeMaipuYCorrientes initializeAfterFileIn!