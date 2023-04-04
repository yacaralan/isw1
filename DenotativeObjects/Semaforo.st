!classDefinition: #ReguladorDeTransitoDeCorrientes category: 'Semaforo'!
DenotativeObject subclass: #ReguladorDeTransitoDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReguladorDeTransitoDeCorrientes class' category: 'Semaforo'!
ReguladorDeTransitoDeCorrientes class
	instanceVariableNames: ''!

!ReguladorDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:09:21'!
apagarSeñalDePrecaucion
	SeñalDePrecaucionDeCorrientes apagar! !

!ReguladorDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:38:48'!
avisarPrecaucion

	SeñalDePrecaucionDeCorrientes prender.
	(Delay for: 0.5*second) wait.
	SeñalDePrecaucionDeCorrientes apagar! !

!ReguladorDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:41:15'!
detenerTransito
	SeñalDeDetencionDeCorrientes prender! !

!ReguladorDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:39:17'!
permitirTransito
	SeñalDeDetencionDeCorrientes apagar.
	self avisarPrecaucion.
	SeñalDeAvanceDeCorrientes prender.
	(Delay for: 1*second) wait.
	SeñalDeAvanceDeCorrientes apagar.
	self avisarPrecaucion .
	! !

!ReguladorDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:11:34'!
prenderSeñalDePrecaucion
	SeñalDePrecaucionDeCorrientes prender! !


!classDefinition: #ReguladorDeTransitoDeMaipu category: 'Semaforo'!
DenotativeObject subclass: #ReguladorDeTransitoDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReguladorDeTransitoDeMaipu class' category: 'Semaforo'!
ReguladorDeTransitoDeMaipu class
	instanceVariableNames: ''!

!ReguladorDeTransitoDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:41:53'!
apagarSeñalDePrecaucion
	SeñalDePrecaucionDeMaipu apagar! !

!ReguladorDeTransitoDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:39:49'!
avisarPrecaucion

	SeñalDePrecaucionDeMaipu prender.
	(Delay for: 0.5*second) wait.
	SeñalDePrecaucionDeMaipu apagar! !

!ReguladorDeTransitoDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:41:29'!
detenerTransito
	SeñalDeDetencionDeMaipu prender! !

!ReguladorDeTransitoDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:40:16'!
permitirTransito
	SeñalDeDetencionDeMaipu apagar.
	self avisarPrecaucion.
	SeñalDeAvanceDeMaipu prender.
	(Delay for: 1*second) wait.
	SeñalDeAvanceDeMaipu apagar.
	self avisarPrecaucion .
	! !

!ReguladorDeTransitoDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 18:42:40'!
prenderSeñalDePrecaucion
	SeñalDePrecaucionDeMaipu prender! !


!classDefinition: #SemaforoDeMaipuYCorrientes category: 'Semaforo'!
DenotativeObject subclass: #SemaforoDeMaipuYCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeMaipuYCorrientes class' category: 'Semaforo'!
SemaforoDeMaipuYCorrientes class
	instanceVariableNames: 'prendido'!

!SemaforoDeMaipuYCorrientes class methodsFor: 'metodos' stamp: 's 4/3/2023 18:46:31'!
avisarPrecaucionDeEncendido

	5 timesRepeat: [self titilarSeñalesDePrecaucion]! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'metodos' stamp: 's 4/3/2023 18:04:29'!
prender	
	self avisarPrecaucionDeEncendido.
	
	ReguladorDeTransitoDeMaipu detenerTransito.
	ReguladorDeTransitoDeCorrientes permitirTransito! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'metodos' stamp: 's 4/3/2023 18:46:31'!
titilarSeñalesDePrecaucion

	ReguladorDeTransitoDeCorrientes prenderSeñalDePrecaucion.
	ReguladorDeTransitoDeMaipu prenderSeñalDePrecaucion.
	(Delay for: 0.5 * second) wait.
	ReguladorDeTransitoDeCorrientes apagarSeñalDePrecaucion.
	ReguladorDeTransitoDeMaipu apagarSeñalDePrecaucion.
	(Delay for: 0.5 * second) wait! !


!SemaforoDeMaipuYCorrientes class methodsFor: '--** private fileout/in **--' stamp: 's 4/3/2023 19:53:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	prendido := nil.! !


!classDefinition: #SeñalDeAvanceDeCorrientes category: 'Semaforo'!
DenotativeObject subclass: #SeñalDeAvanceDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceDeCorrientes class' category: 'Semaforo'!
SeñalDeAvanceDeCorrientes class
	instanceVariableNames: 'color'!

!SeñalDeAvanceDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:49:54'!
apagar
	color := Color black! !

!SeñalDeAvanceDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:49:44'!
prender
	color := Color green! !


!SeñalDeAvanceDeCorrientes class methodsFor: '--** private fileout/in **--' stamp: 's 4/3/2023 19:53:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	color := (Color r: 0.082 g: 0.690 b: 0.102).! !


!classDefinition: #SeñalDeAvanceDeMaipu category: 'Semaforo'!
DenotativeObject subclass: #SeñalDeAvanceDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceDeMaipu class' category: 'Semaforo'!
SeñalDeAvanceDeMaipu class
	instanceVariableNames: 'color'!

!SeñalDeAvanceDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:54:46'!
apagar
	color := Color black! !

!SeñalDeAvanceDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:54:35'!
prender
	color := Color green! !


!SeñalDeAvanceDeMaipu class methodsFor: '--** private fileout/in **--' stamp: 's 4/3/2023 19:53:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	color := nil.! !


!classDefinition: #SeñalDeDetencionDeCorrientes category: 'Semaforo'!
DenotativeObject subclass: #SeñalDeDetencionDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionDeCorrientes class' category: 'Semaforo'!
SeñalDeDetencionDeCorrientes class
	instanceVariableNames: 'color'!

!SeñalDeDetencionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:54:54'!
apagar
	color := Color black! !

!SeñalDeDetencionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:55:01'!
prender
	color := Color red! !


!SeñalDeDetencionDeCorrientes class methodsFor: '--** private fileout/in **--' stamp: 's 4/3/2023 19:53:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	color := nil.! !


!classDefinition: #SeñalDeDetencionDeMaipu category: 'Semaforo'!
DenotativeObject subclass: #SeñalDeDetencionDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionDeMaipu class' category: 'Semaforo'!
SeñalDeDetencionDeMaipu class
	instanceVariableNames: 'color'!

!SeñalDeDetencionDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:55:07'!
apagar
	color := Color black! !

!SeñalDeDetencionDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:55:15'!
prender
	color := Color red! !


!SeñalDeDetencionDeMaipu class methodsFor: '--** private fileout/in **--' stamp: 's 4/3/2023 19:53:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	color := nil.! !


!classDefinition: #SeñalDePrecaucionDeCorrientes category: 'Semaforo'!
DenotativeObject subclass: #SeñalDePrecaucionDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionDeCorrientes class' category: 'Semaforo'!
SeñalDePrecaucionDeCorrientes class
	instanceVariableNames: 'color'!

!SeñalDePrecaucionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:55:44'!
apagar
	color := Color black! !

!SeñalDePrecaucionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 17:55:54'!
prender
	color := Color yellow! !


!SeñalDePrecaucionDeCorrientes class methodsFor: '--** private fileout/in **--' stamp: 's 4/3/2023 19:53:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	color := nil.! !


!classDefinition: #SeñalDePrecaucionDeMaipu category: 'Semaforo'!
DenotativeObject subclass: #SeñalDePrecaucionDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionDeMaipu class' category: 'Semaforo'!
SeñalDePrecaucionDeMaipu class
	instanceVariableNames: 'color'!

!SeñalDePrecaucionDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 3/30/2023 19:00:48'!
apagar
	color := Color black! !

!SeñalDePrecaucionDeMaipu class methodsFor: 'as yet unclassified' stamp: 's 3/30/2023 19:00:40'!
prender
	color := Color yellow! !


!SeñalDePrecaucionDeMaipu class methodsFor: '--** private fileout/in **--' stamp: 's 4/3/2023 19:53:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	color := (Color r: 1.000 g: 1.000 b: 0.078).! !

SemaforoDeMaipuYCorrientes initializeAfterFileIn!
SeñalDeAvanceDeCorrientes initializeAfterFileIn!
SeñalDeAvanceDeMaipu initializeAfterFileIn!
SeñalDeDetencionDeCorrientes initializeAfterFileIn!
SeñalDeDetencionDeMaipu initializeAfterFileIn!
SeñalDePrecaucionDeCorrientes initializeAfterFileIn!
SeñalDePrecaucionDeMaipu initializeAfterFileIn!