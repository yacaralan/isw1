!classDefinition: #I category: 'NumerosNaturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NumerosNaturales'!
I class
	instanceVariableNames: 'next prev'!

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 20:27:03'!
* aNaturalNumber
	^aNaturalNumber ! !

!I class methodsFor: 'Operations' stamp: 'L 4/3/2023 17:20:50'!
+ aNaturalNumber
	^ aNaturalNumber next.! !

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 21:54:42'!
- aNaturalNumber
	self  error: 'no se puede'! !

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 20:48:00'!
/ aDivisor
	^aDivisor timesDivideTo: self ! !

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 20:53:26'!
divideWithDividendGreaterEqualThanDivisor: aDividend  and: aDivisor
	^self! !

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 20:31:06'!
multiplyByBiggerThanOne: aNaturalNumberBiggerThanOne
	^aNaturalNumberBiggerThanOne! !

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 21:28:11'!
next
	next ifNil: [
		next _ self cloneNamed: self name , 'I'.
		next previous: self ].
	^ next.! !

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 21:28:24'!
previous: previous
	prev := previous.! !

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 21:53:06'!
substractFrom: aNaturalNumber
 	^ aNaturalNumber prev! !

!I class methodsFor: 'Operations' stamp: 's 3/30/2023 20:48:00'!
timesDivideTo: aNaturalNumber
	^aNaturalNumber ! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'L 4/3/2023 17:33:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.
	prev := nil.! !


!classDefinition: #II category: 'NumerosNaturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NumerosNaturales'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'Operations' stamp: 's 3/30/2023 20:29:06'!
* aNaturalNumber
	^aNaturalNumber multiplyByBiggerThanOne: self! !

!II class methodsFor: 'Operations' stamp: 'L 4/3/2023 17:25:31'!
+ aNaturalNumber
	^self prev + aNaturalNumber next! !

!II class methodsFor: 'Operations' stamp: 's 3/30/2023 21:55:47'!
- aNaturalNumber
	^aNaturalNumber  substractFrom: self! !

!II class methodsFor: 'Operations' stamp: 'L 4/3/2023 17:31:58'!
/ aNaturalNumber
	^aNaturalNumber timesDivideTo: self ! !

!II class methodsFor: 'Operations' stamp: 's 3/30/2023 21:00:11'!
divideWithDividendGreaterEqualThanDivisor: aDividend  and: aDivisor
	^[aDividend - aDivisor / aDivisor + I]
		on: Error
		do: [I]! !

!II class methodsFor: 'Operations' stamp: 's 3/30/2023 20:30:49'!
multiplyByBiggerThanOne: aNaturalNumberBiggerThanOne
	^aNaturalNumberBiggerThanOne + (self prev * aNaturalNumberBiggerThanOne )! !

!II class methodsFor: 'Operations' stamp: 's 3/30/2023 21:29:52'!
next
	next ifNil: [
		next := II createChildNamed: self name , 'I'.
		next previous: self ].
	^ next.! !

!II class methodsFor: 'Operations' stamp: 'L 4/3/2023 17:28:44'!
prev
	^prev! !

!II class methodsFor: 'Operations' stamp: 's 3/30/2023 21:27:45'!
previous: previous
	prev := previous .! !

!II class methodsFor: 'Operations' stamp: 's 3/30/2023 21:53:41'!
substractFrom: aNaturalNumber
 	^aNaturalNumber prev - self prev! !

!II class methodsFor: 'Operations' stamp: 's 3/30/2023 20:54:05'!
timesDivideTo: aDividend
	^[(aDividend + I - self) divideWithDividendGreaterEqualThanDivisor: aDividend  and: self]
		on: Error
		do: [self error: self canNotDivideByBiggerNumberErrorDescription]! !


!II class methodsFor: 'Error descriptions' stamp: 's 3/30/2023 21:08:53'!
canNotDivideByBiggerNumberErrorDescription
	^'La tenes muy chiquita para que te divida semejante magnitud'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'L 4/3/2023 17:33:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !


!classDefinition: #III category: 'NumerosNaturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NumerosNaturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'L 4/3/2023 17:33:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !


!classDefinition: #IIII category: 'NumerosNaturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'NumerosNaturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'L 4/3/2023 17:33:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	prev := III.! !


!classDefinition: #IIIII category: 'NumerosNaturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'NumerosNaturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'L 4/3/2023 17:33:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	prev := IIII.! !


!classDefinition: #IIIIII category: 'NumerosNaturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'NumerosNaturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'L 4/3/2023 17:33:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	prev := IIIII.! !


!classDefinition: #IIIIIII category: 'NumerosNaturales'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'NumerosNaturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'L 4/3/2023 17:33:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := IIIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!