!classDefinition: #CartTests category: 'TusLibros'!
TestCase subclass: #CartTests
	instanceVariableNames: 'aBookCatalogue myCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTests methodsFor: 'setUp/tearDown' stamp: 'LMR 6/8/2023 18:20:40'!
setUp

	aBookCatalogue := Set with: #book1 with: #book2 with: #book3.
	myCart := Cart withCatalogue: aBookCatalogue.! !


!CartTests methodsFor: 'assertions' stamp: 'LMR 6/8/2023 01:38:38'!
canNotAdd: anAmountOfCopies copiesOfBook: aBook toCart: aCart errorDescription: anErrorDescription

	^ self should: [aCart add: aBook amount: anAmountOfCopies.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = anErrorDescription]! !

!CartTests methodsFor: 'assertions' stamp: 'LMR 6/8/2023 01:27:24'!
canNotAddBook: aBook toCart: aCart

	^ self should: [aCart add: aBook.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = Cart bookNotInStoreErrorDescrition]! !


!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 00:10:03'!
test01NewCartStartsEmpty

	self assert: Cart new isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 01:34:11'!
test02AddingABookToACartAddsIt

	myCart add: #book1.
	
	self deny: myCart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 01:43:15'!
test03CanAddMoreThanOneOfTheSameBook

	| expected |
	myCart add: #book1.
	myCart add: #book1.
	myCart add: #book1.
	
	expected := Bag with: #book1 with: #book1 with: #book1.
	self assert: myCart listCart equals: expected.! !

!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 01:35:01'!
test04CanAddDifferentBooks

	| expected |
	myCart add: #book1.
	myCart add: #book2.
	myCart add: #book3.
	
	expected := Bag with: #book1 with: #book2 with: #book3.
	self assert: myCart listCart equals: expected.! !

!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 01:35:17'!
test05CanAddMultipleCopiesOfABookAtOnce

	| expected |
	myCart add: #book1 amount: 3.
	
	expected := Bag new.
	expected add: #book1 withOccurrences: 3.
	self assert: myCart listCart equals: expected.! !

!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 01:35:52'!
test06CanNotAddInvalidBook

	self canNotAddBook: #book5 toCart: myCart.
	self assert: myCart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 01:39:25'!
test07CanNotAddMultipleCopiesOfInvalidBookAtOnce

	self canNotAdd: 5 copiesOfBook: #book5 toCart: myCart errorDescription: Cart bookNotInStoreErrorDescrition.	
	self assert: myCart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 01:40:18'!
test08CanNotAddInvalidAmountOfCopiesOfABookAtOnce

	self canNotAdd: 0 copiesOfBook: #book1 toCart: myCart errorDescription: Cart invalidAmountOfItemsErrorDescription.
	self assert: myCart isEmpty.
	self canNotAdd: -2 copiesOfBook: #book1 toCart: myCart errorDescription: Cart invalidAmountOfItemsErrorDescription.
	self assert: myCart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'LMR 6/8/2023 18:26:58'!
test09CanNotAddInvalidAmountOfCopies

	self canNotAdd: 1.1 copiesOfBook: #book1 toCart: myCart errorDescription: Cart invalidAmountOfItemsErrorDescription.
	self assert: myCart isEmpty.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'empty products storeCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'LMR 6/8/2023 00:30:40'!
isEmpty
	
	^products isEmpty.! !


!Cart methodsFor: 'add' stamp: 'LMR 6/8/2023 16:14:55'!
add: aBook 
	
	self add: aBook amount: 1.! !

!Cart methodsFor: 'add' stamp: 'LMR 6/8/2023 18:25:34'!
add: aBook amount: anAmount 
	
	self canAddBook: aBook withAmount: anAmount.
	products add: aBook withOccurrences: anAmount.! !


!Cart methodsFor: 'list' stamp: 'LMR 6/8/2023 18:34:36'!
listCart
	
	^products copy.! !


!Cart methodsFor: 'validations' stamp: 'LMR 6/8/2023 18:33:08'!
canAddBook: aBook withAmount: anAmount

	(storeCatalogue includes: aBook) ifFalse: [self error: self class bookNotInStoreErrorDescrition].
	((anAmount isKindOf: Integer) and: anAmount > 0) ifFalse: [self error: self class invalidAmountOfItemsErrorDescription]! !


!Cart methodsFor: 'initialization' stamp: 'LMR 6/8/2023 18:20:16'!
initialize

	products := Bag new.
	storeCatalogue := Set new.! !

!Cart methodsFor: 'initialization' stamp: 'LMR 6/8/2023 18:20:23'!
initializeWithCatalogue: aBookCatalogue 
	
	products := Bag new.
	storeCatalogue := aBookCatalogue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LMR 6/8/2023 01:42:05'!
withCatalogue: aBookCatalogue 
	
	^self new initializeWithCatalogue: aBookCatalogue.! !


!Cart class methodsFor: 'error descriptions' stamp: 'LMR 6/8/2023 00:56:15'!
bookNotInStoreErrorDescrition

	^'Book not in store'.! !

!Cart class methodsFor: 'error descriptions' stamp: 'LMR 6/8/2023 01:41:03'!
invalidAmountOfItemsErrorDescription

	^'Invalid amount of items to add to cart'.! !
