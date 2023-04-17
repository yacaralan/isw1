!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'a 4/16/2023 21:53:19'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'a 4/16/2023 21:53:33'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'a 4/16/2023 21:53:53'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'a 4/16/2023 21:54:17'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'a 4/16/2023 21:52:47'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:01:55'!
* aMultiplier 

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:01:51'!
+ anAdder 
	
	self subclassResponsibility 
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:24:45'!
negated
	
	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'a 4/16/2023 21:27:36'!
isNegative
	
	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'a 4/16/2023 21:28:28'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'a 4/16/2023 21:30:00'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 20:55:27'!
* aMultiplier 

	(aMultiplier isKindOf: self class) ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].
		
	self error: 'Tipo de número no soportado'
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 20:59:54'!
+ anAdder 
	
	(anAdder isKindOf: self class) ifTrue:
		[ ^self class with: value + anAdder integerValue ].
	
	self error: 'Tipo de número no soportado'
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:05:04'!
// aDivisor 
	
	(aDivisor isKindOf: self class ) ifTrue:
		[ ^self class with: value // aDivisor integerValue ].
		
	self error: 'Tipo de número no soportado'! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:22:52'!
greatestCommonDivisorWith: anEntero 
	
	(anEntero isKindOf: self class ) ifTrue:
		[^self class with: (value gcd: anEntero integerValue)].
		
	self error: 'Tipo de número no soportado'! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:23:59'!
negated
	
	^self * (self class with: -1) ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:26:21'!
printOn: aStream
	
	aStream print: value! !


!Entero methodsFor: 'accessing' stamp: 'a 4/16/2023 20:43:45'!
integerValue
	
	^value! !


!Entero methodsFor: 'testing' stamp: 'a 4/16/2023 21:27:22'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'a 4/16/2023 21:29:29'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'a 4/16/2023 21:29:52'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'comparing' stamp: 'a 4/16/2023 21:16:23'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue] ! !

!Entero methodsFor: 'comparing' stamp: 'a 4/16/2023 21:17:33'!
hash
	
	 ^value hash! !


!Entero methodsFor: 'initialization' stamp: 'a 4/16/2023 21:47:25'!
initializeWith: aValue

	value := aValue 

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'a 4/16/2023 21:41:00'!
with: aValue 
	
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 20:54:15'!
* aMultiplier 

	(aMultiplier isKindOf: self class)  ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) over: 		(denominator * aMultiplier denominator) ].
		
	self error: 'Tipo de número no soportado'
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:00:53'!
+ anAdder 
	
	(anAdder isKindOf: self class) ifTrue:
		[ | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + 						(denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ].
	
	self error: 'Tipo de número no soportado'
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:55:25'!
negated
	
	^self class with: numerator * (Entero with: -1) over: denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 4/16/2023 21:25:58'!
printOn: aStream
	
	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator! !


!Fraccion methodsFor: 'testing' stamp: 'a 4/16/2023 21:27:55'!
isNegative
	
	^denominator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'a 4/16/2023 21:28:18'!
isOne
	
	^false ! !

!Fraccion methodsFor: 'testing' stamp: 'a 4/16/2023 21:30:12'!
isZero
	
	^false ! !


!Fraccion methodsFor: 'initialization' stamp: 'a 4/16/2023 21:48:18'!
initializeWith: aNumerator over: aDenominator

	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'comparing' stamp: 'a 4/16/2023 21:15:53'!
= anObject

	^(anObject isKindOf: self class)  and:
			[ (numerator * anObject denominator) = (denominator * 			anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'a 4/16/2023 21:17:59'!
hash
	
	 ^(numerator hash / denominator hash) hash ! !


!Fraccion methodsFor: 'accessing' stamp: 'a 4/16/2023 20:41:04'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'a 4/16/2023 20:44:37'!
numerator

	^numerator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'a 4/16/2023 21:48:51'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
