!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'aPrefixStartingWithLowerCase aPrefixStartingWithUpperCase prefixEndingWithWhiteSpace prefixStartingWithWhiteSpace prefixWithWhiteSpace emptyStack emptyPrefix finder emptyCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'LMR 4/22/2023 20:14:25'!
setUp

	aPrefixStartingWithLowerCase := 'hola'.
	aPrefixStartingWithUpperCase := 'Hola'.
	prefixEndingWithWhiteSpace := 'hola '.
	prefixStartingWithWhiteSpace := ' hola'.
	prefixWithWhiteSpace := 'hola chau'.
	emptyPrefix := ''.
	
	emptyStack := OOStack new.
		
	finder := SentenceFinderByPrefix new.
	
	emptyCollection := OrderedCollection new.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:12:20'!
test01EmptyPrefixShouldThrowError
	
	self
		should: [ finder findSentencesWithPrefix: emptyPrefix inStack: emptyStack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ]
		
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:12:26'!
test02PrefixWithWhiteSpaceShouldThrowError	
	
	self
		should: [ finder findSentencesWithPrefix: prefixWithWhiteSpace inStack: emptyStack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixContainsWhiteSpaceErrorDescription ].
		
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:14:46'!
test03PrefixStartingWithWhiteSpaceThrowsError
	
	self
		should: [ finder findSentencesWithPrefix: prefixStartingWithWhiteSpace inStack: emptyStack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixContainsWhiteSpaceErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:14:40'!
test04PrefixEndingWithWhiteSpaceThrowsError
	
	self
		should: [ finder findSentencesWithPrefix: prefixEndingWithWhiteSpace inStack: emptyStack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixContainsWhiteSpaceErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:14:01'!
test05ShouldNotFindSentencesWithEmptyStack
	
	| result |
	
	result := finder findSentencesWithPrefix: aPrefixStartingWithLowerCase inStack: emptyStack.
	
	self assert: result = emptyCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:18:07'!
test06ShouldNotFindSentencesWhenPrefixDoesNotMatchAny
	
	| result aStack |
	
	aStack := OOStack new.
	aStack push: 'no'.
	aStack push: 'coincide'.
	
	result := finder findSentencesWithPrefix: aPrefixStartingWithLowerCase inStack: aStack.
	
	self assert: result = emptyCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:26:51'!
test07ShouldNotFindSentencesWhenPrefixDoesNotMatchCasing
	
	| result aStack |
	
	aStack := OOStack new.
	aStack push: 'hola'.
	aStack push: 'este no coincide por casing'.
	
	result := finder findSentencesWithPrefix: aPrefixStartingWithUpperCase inStack: aStack.
	
	self assert: result = emptyCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:25:16'!
test08ShouldFindSentencesWhenPrefixMatchesOneSentence
	
	| result aStack collectionWithLowerHola |
	
	aStack := OOStack new.
	aStack push: 'holaaaa me encontraste'.
	aStack push: 'este coincide'.
	
	result := finder findSentencesWithPrefix: aPrefixStartingWithLowerCase inStack: aStack.
	
	collectionWithLowerHola := OrderedCollection new.
	collectionWithLowerHola add: 'holaaaa me encontraste'.
	
	self assert: result = collectionWithLowerHola.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:32:36'!
test09ShouldFindMoreThanOneSentenceWhenPrefixMatchesMoreThanOneSentence
	
	| result aStack collectionWithLowerHolaMatches |
	
	aStack := OOStack new.
	aStack push: 'holaaaa me encontraste'.
	aStack push: 'este no coincide'.	
	aStack push: 'hola como estas yo bien y vos?'.	
	aStack push: 'hola y chau'.
	aStack push: 'nos vemos'.
	
	result := finder findSentencesWithPrefix: aPrefixStartingWithLowerCase inStack: aStack.
	
	collectionWithLowerHolaMatches := OrderedCollection new.
	collectionWithLowerHolaMatches add: 'holaaaa me encontraste'.
	collectionWithLowerHolaMatches add: 'hola como estas yo bien y vos?'.
	collectionWithLowerHolaMatches add: 'hola y chau'.
	
	self assert: result = collectionWithLowerHolaMatches.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:43:09'!
test10ShouldNotModifyStackWhenPrefixMatchesASentence
	
	| aStack |
	
	aStack := OOStack new.
	aStack push: 'hola soy el primero'.
	aStack push: 'Hola soy el segundo'.	
	aStack push: 'hola soy el tercero'.
	
	finder findSentencesWithPrefix: aPrefixStartingWithUpperCase inStack: aStack.
	
	self assert: aStack pop = 'hola soy el tercero'.
	self assert: aStack pop = 'Hola soy el segundo'.
	self assert: aStack pop = 'hola soy el primero'.
	self assert: aStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LMR 4/22/2023 20:43:27'!
test11ShouldNotModifyStackWhenPrefixDoesNotMatchASentence
	
	| aStack |
	
	aStack := OOStack new.
	aStack push: 'hola soy el primero'.
	aStack push: 'hola soy el segundo'.	
	aStack push: 'hola soy el tercero'.
	
	finder findSentencesWithPrefix: aPrefixStartingWithUpperCase inStack: aStack.
	
	self assert: aStack pop = 'hola soy el tercero'.
	self assert: aStack pop = 'hola soy el segundo'.
	self assert: aStack pop = 'hola soy el primero'.
	self assert: aStack isEmpty.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements stackState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'standar stack methods' stamp: 'a 4/20/2023 23:10:45'!
isEmpty
	
	^stackState isEmpty! !

!OOStack methodsFor: 'standar stack methods' stamp: 'a 4/21/2023 00:12:34'!
pop	

	stackState popStateOfStack: self.
	^elements removeLast.
	
 ! !

!OOStack methodsFor: 'standar stack methods' stamp: 'a 4/21/2023 00:15:23'!
push: anElement

	stackState 	pushNextStateToStack: self.
	elements addLast: anElement.
! !

!OOStack methodsFor: 'standar stack methods' stamp: 'a 4/21/2023 00:09:44'!
size
	
	^elements size ! !

!OOStack methodsFor: 'standar stack methods' stamp: 'a 4/21/2023 00:18:12'!
top

	stackState errorIfEmptyState.
	^elements at: elements size ! !


!OOStack methodsFor: 'initializer' stamp: 'a 4/21/2023 00:25:23'!
initialize
	elements := OrderedCollection new.
	stackState := EmptyStack new.
! !


!OOStack methodsFor: 'aux methods' stamp: 'a 4/21/2023 00:37:00'!
setState: aStackState
	
	stackState := aStackState ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 's 4/20/2023 21:04:53'!
new
	^ self basicNew initialize! !

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !

!OOStack class methodsFor: 'error descriptions' stamp: 'LMR 4/22/2023 18:30:03'!
throwEmptyStackError

	^ self error: self stackEmptyErrorDescription! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'internalStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LMR 4/22/2023 20:34:16'!
findSentencesWithPrefix: aPrefix inStack: aStack

	| value result |
	aPrefix isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription].
	(aPrefix findString: ' ') = 0 ifFalse: [self error: self class prefixContainsWhiteSpaceErrorDescription].
	result := OrderedCollection new.
	
	[aStack isEmpty] whileFalse: [ 
	value := aStack pop.
	internalStack push: value.
	(value beginsWith: aPrefix) ifTrue: [result addFirst: value].
	].

	[internalStack isEmpty] whileFalse: [
		aStack push: internalStack pop
	].
	^result! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LMR 4/22/2023 19:26:30'!
initialize

	internalStack := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'LMR 4/22/2023 18:44:08'!
emptyPrefixErrorDescription
	
	^'prefix should not be empty!!'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'LMR 4/22/2023 18:43:58'!
prefixContainsWhiteSpaceErrorDescription
	
	^'prefix should not contain a white space!!'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'LMR 4/22/2023 19:24:59'!
new
	^self basicNew initialize! !


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'stack methods' stamp: 'a 4/21/2023 00:18:00'!
errorIfEmptyState

	self subclassResponsibility ! !

!StackState methodsFor: 'stack methods' stamp: 'a 4/21/2023 00:16:06'!
isEmpty

	self subclassResponsibility ! !

!StackState methodsFor: 'stack methods' stamp: 'a 4/21/2023 00:12:21'!
popStateOfStack: aStack

	self subclassResponsibility ! !

!StackState methodsFor: 'stack methods' stamp: 'a 4/21/2023 00:38:27'!
pushNextStateToStack: aStack

	aStack setState: (NotEmptyStack newWithPreviousState: self)! !


!classDefinition: #EmptyStack category: 'Stack-Exercise'!
StackState subclass: #EmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStack methodsFor: 'state methods' stamp: 'LMR 4/22/2023 18:32:55'!
errorIfEmptyState

	OOStack throwEmptyStackError! !

!EmptyStack methodsFor: 'state methods' stamp: 'a 4/20/2023 23:12:05'!
isEmpty
	
	^true! !

!EmptyStack methodsFor: 'state methods' stamp: 'LMR 4/22/2023 18:32:39'!
popStateOfStack: aStack

	OOStack throwEmptyStackError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStack class' category: 'Stack-Exercise'!
EmptyStack class
	instanceVariableNames: ''!

!EmptyStack class methodsFor: 'as yet unclassified' stamp: 's 4/20/2023 21:57:33'!
new
	
	^self basicNew initialize ! !


!classDefinition: #NotEmptyStack category: 'Stack-Exercise'!
StackState subclass: #NotEmptyStack
	instanceVariableNames: 'previousState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStack methodsFor: 'state methods' stamp: 'a 4/21/2023 00:17:35'!
errorIfEmptyState! !

!NotEmptyStack methodsFor: 'state methods' stamp: 'a 4/20/2023 23:12:15'!
isEmpty
	
	^false! !

!NotEmptyStack methodsFor: 'state methods' stamp: 'a 4/21/2023 00:37:23'!
popStateOfStack: aStack

	aStack setState: previousState 
! !


!NotEmptyStack methodsFor: 'initializer' stamp: 'a 4/20/2023 23:33:12'!
initializeWithPreviousState: aStackState
	
	previousState := aStackState ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyStack class' category: 'Stack-Exercise'!
NotEmptyStack class
	instanceVariableNames: ''!

!NotEmptyStack class methodsFor: 'as yet unclassified' stamp: 'a 4/20/2023 23:30:41'!
newWithPreviousState: aStackState
	
	^self basicNew initializeWithPreviousState: aStackState ! !
