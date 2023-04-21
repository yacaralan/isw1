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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


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


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


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

!EmptyStack methodsFor: 'state methods' stamp: 'a 4/21/2023 00:17:11'!
errorIfEmptyState

	OOStack error: OOStack stackEmptyErrorDescription! !

!EmptyStack methodsFor: 'state methods' stamp: 'a 4/20/2023 23:12:05'!
isEmpty
	
	^true! !

!EmptyStack methodsFor: 'state methods' stamp: 'a 4/21/2023 00:11:30'!
popStateOfStack: aStack

	aStack error: aStack class stackEmptyErrorDescription! !

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
