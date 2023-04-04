!classDefinition: #XXX category: 'CollectionExercise'!
Object subclass: #XXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CollectionExercise'!

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:41:54'!
extractVowels
        ^'abcdefguijp' select: [:char| char isVowel].! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:41:59'!
findDoublesCollect
        ^#(1 2 5 6 9) collect:[:each| each*2]
! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:02'!
findDoublesDo
        | elements doubles |

        elements:= #(1 2 5 6 9).
	
	doubles := OrderedCollection new.
        elements do: [:each| doubles add: each * 2 ].
       
        ^doubles! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:07'!
findDoublesMult
        ^#(1 2 5 6 9)*2
! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:12'!
findDoublesWhile
        | elements doubles index |

        elements:= #(1 2 5 6 9).

	doubles := OrderedCollection new.
	index := 1.
	
	 [index <= elements size]
        whileTrue: [
		doubles add: (elements at: index)*2.
                index := index +1.
                ].
       
        ^doubles! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:19'!
findFirstEven
       ^#(1 2 5 6 9) detect: [:each| each even].! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:23'!
findFirstEvenWithoutMatching
        ^#(1 5 9) detect: [:each| each even].! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:28'!
findFirstEvenWithoutMatchingReturnString
        ^#(1 5 9) detect: [:each| each even] ifNone: ['no hay pares'].! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:31'!
findFirstEvenWithoutMatchingThrowsException
        ^#(1 5 9) detect: [:each| each even] ifNone: [self error:'No hay pares'].! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:35'!
findOddsPart0
        | elements index odds |

        elements:= #(1 2 5 6 9).

        odds := OrderedCollection new.
        index := 1.

        [index <= elements size]
        whileTrue: [
                ((elements at: index) odd) ifTrue: [odds add: (elements at: index)].
                index := index +1.
                ].
        ^odds! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:39'!
findOddsPart1
        | elements odds |

        elements:= #(1 2 5 6 9).

        odds := OrderedCollection new.
        elements do: [:each| each odd ifTrue: [odds add: each] ].
        ^odds! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:43'!
findOddsPart2
        ^#(1 2 5 6 9) select: [:each| each odd].
! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:48'!
findOddsPart3
        | elements odds |

        elements:= #(1 2 5 6 9).

        odds := elements select: [:each| each odd ].
        ^odds! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:52'!
sumElementsInjecting
        ^#(1 5 9) inject: 0 into: [:suma :elem | suma + elem].! !

!XXX methodsFor: 'as yet unclassified' stamp: 's 4/3/2023 21:42:55'!
sumElementsSum
        ^#(1 5 9) sum.! !
