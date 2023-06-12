!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CheckoutTest category: 'TusLibros'!
TestCase subclass: #CheckoutTest
	instanceVariableNames: 'myCart myPriceList anExpiredCreditCard anUnamedCard anInvalidCard aCardWithInsufficientFunds aStolenCard aCardFunds myMockMerchantProcessor aValidCard aCardWithMoreThan30CharactersOnItsName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 00:02:16'!
test01CanNotCheckoutEmptyCart

	| aCheckout |
	aCheckout := Checkout of: myCart withCard: aValidCard withPrices: myPriceList.
	self should: [aCheckout checkout]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Checkout emptyCartErrorDescription.]. ! !

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 00:14:43'!
test02CartWithOneItemChecksoutCorrectly

	| aCheckout |
	myCart add: 'book1'.
	aCheckout := Checkout of: myCart withCard: aValidCard withPrices: myPriceList.
	self assert: aCheckout checkout equals: 100.! !

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 00:14:47'!
test03CartWithMoreThanOneItemChecksoutCorrectly

	| aCheckout |
	myCart add: 3 of: 'book1'.
	aCheckout := Checkout of: myCart withCard: aValidCard withPrices: myPriceList.
	self assert: aCheckout checkout equals: 300.! !

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 00:14:50'!
test04CanNotCheckoutWithCardWithEmptyName

	| aCheckout |
	myCart add: 3 of: 'book1'.
	aCheckout := Checkout of: myCart withCard: anUnamedCard withPrices: myPriceList.
	self should: [aCheckout checkout]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText equals: Checkout canNotCheckoutWithCardWithEmptyName].! !

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 00:14:52'!
test05CanNotCheckoutWithCardWithInvalidNumberOfDigits

	| aCheckout |
	myCart add: 3 of: 'book1'.
	aCheckout := Checkout of: myCart withCard: anInvalidCard withPrices: myPriceList.
	self should: [aCheckout checkout]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText equals: Checkout canNotCheckoutWithCardWithInvalidNumberOfDigits].! !

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 00:14:56'!
test06CanNotCheckoutWithExpiredCard

	| aCheckout |
	myCart add: 3 of: 'book1'.
	aCheckout := Checkout of: myCart withCard: anExpiredCreditCard withPrices: myPriceList.
	self should: [aCheckout checkout]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText equals: Checkout canNotCheckoutWithExpiredCard].! !

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 15:27:28'!
test07CanNotCheckoutIfCardNameLenghtExceeds30Characters

	| aCheckout |
	myCart add: 3 of: 'book1'.
	aCheckout := Checkout of: myCart withCard: aCardWithMoreThan30CharactersOnItsName withPrices: myPriceList.
	self should: [myMockMerchantProcessor debit: aCheckout checkout fromCard: aCardWithMoreThan30CharactersOnItsName.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText equals: Checkout cardNameIsTooLongErrorDescription].! !

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 15:27:32'!
test08CanNotCheckOutIfCardHasInsufficientFunds

	| aCheckout |
	myCart add: 3 of: 'book1'.
	aCheckout := Checkout of: myCart withCard: aCardWithInsufficientFunds withPrices: myPriceList.
	self should: [myMockMerchantProcessor debit: aCheckout checkout fromCard: aCardWithInsufficientFunds.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText equals: MockMerchantProcessor insufficientFundsErrorDescription].! !

!CheckoutTest methodsFor: 'tests' stamp: 'LMR 6/12/2023 15:27:05'!
test09CanNotCheckOutIfCardIsStolen

	| aCheckout |
	myCart add: 3 of: 'book1'.
	aCheckout := Checkout of: myCart withCard: aStolenCard withPrices: myPriceList.
	self should: [myMockMerchantProcessor debit: aCheckout checkout fromCard: aStolenCard.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText equals: MockMerchantProcessor stolenCardErrorDescription].! !


!CheckoutTest methodsFor: 'setUp/tearDown' stamp: 'LMR 6/12/2023 15:13:57'!
setUp

	myCart := Cart acceptingItemsOf: (OrderedCollection with: 'book1' with: 'book2' with: 'book3').
	myPriceList := Dictionary new.
	myPriceList at: 'book1' put: 100.
	myPriceList at: 'book2' put: 50.
	myPriceList at: 'book3' put: 10.
	
	anExpiredCreditCard := (CreditCard name: 'Jorge' number: '1234567890123456' expirationDate: (GregorianMonthOfYear current previous)).
	anUnamedCard := (CreditCard name: '' number: '1234567891123456' expirationDate: (GregorianMonthOfYear current next)).
	anInvalidCard := (CreditCard name: 'Jorge' number: '12345678' expirationDate: (GregorianMonthOfYear current next)).
	aValidCard := (CreditCard name: 'Jorge' number: '1234567890123457' expirationDate: (GregorianMonthOfYear current next)).
	aCardWithInsufficientFunds := (CreditCard name: 'Jorge' number: '1034567890123456' expirationDate: (GregorianMonthOfYear current next)).
	aStolenCard := (CreditCard name: 'Jorge' number: '1204567890123456' expirationDate: (GregorianMonthOfYear current next)).
	aCardWithMoreThan30CharactersOnItsName := (CreditCard name: 'HolaComoEstasMeLlamoJorgeGonzales' number: '1204560890123456' expirationDate: (GregorianMonthOfYear current next)).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'LMR 6/11/2023 22:03:19'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'LMR 6/11/2023 22:04:26'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'checkout' stamp: 'LMR 6/11/2023 22:15:29'!
sendProductsTo: aCheckout

	items do: [:item | aCheckout processProducts: item.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Checkout category: 'TusLibros'!
Object subclass: #Checkout
	instanceVariableNames: 'cart creditCard priceList total merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Checkout methodsFor: 'initialization' stamp: 'LMR 6/12/2023 00:12:02'!
initializeOf: aCart withCard: aCreditCard withPrices: aPriceList 
	
	cart := aCart.
	creditCard := aCreditCard.
	priceList := aPriceList.
	total := 0.
	merchantProcessor := MockMerchantProcessor new.! !


!Checkout methodsFor: 'checkout' stamp: 'LMR 6/12/2023 15:02:30'!
checkout
	
	self validateCart.
	self validateCard.
	cart sendProductsTo: self.
	self debitTotal.
	^total.! !

!Checkout methodsFor: 'checkout' stamp: 'LMR 6/11/2023 23:23:26'!
debitTotal

	merchantProcessor debit: total fromCard: creditCard.! !

!Checkout methodsFor: 'checkout' stamp: 'LMR 6/11/2023 22:12:19'!
processProducts: aProduct

	total := total + (priceList at: aProduct).! !


!Checkout methodsFor: 'validations' stamp: 'LMR 6/12/2023 15:18:23'!
validateCard

	creditCard hasEmptyName ifTrue: [self error: self class canNotCheckoutWithCardWithEmptyName].
	creditCard has16DigitNumber ifFalse: [self error: self class canNotCheckoutWithCardWithInvalidNumberOfDigits].
	creditCard isExpired ifTrue: [self error: self class canNotCheckoutWithExpiredCard].
	creditCard nameExceedsMaximumLength ifTrue: [self error: self class cardNameIsTooLongErrorDescription].! !

!Checkout methodsFor: 'validations' stamp: 'LMR 6/12/2023 15:02:30'!
validateCart

	^ cart isEmpty ifTrue: [self error: self class emptyCartErrorDescription.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Checkout class' category: 'TusLibros'!
Checkout class
	instanceVariableNames: ''!

!Checkout class methodsFor: 'instance creation' stamp: 'LMR 6/11/2023 21:54:53'!
of: aCart withCard: aCreditCard withPrices: aPriceList 
	
	^self new initializeOf: aCart withCard: aCreditCard withPrices: aPriceList. ! !


!Checkout class methodsFor: 'error descriptions' stamp: 'LMR 6/11/2023 22:23:53'!
canNotCheckoutWithCardWithEmptyName
	
	^'Can not checkout with a credit card with empty name'.! !

!Checkout class methodsFor: 'error descriptions' stamp: 'LMR 6/11/2023 22:28:42'!
canNotCheckoutWithCardWithInvalidNumberOfDigits
	
	^'Can not checkout with a credit card with an invalid amount of digits'.! !

!Checkout class methodsFor: 'error descriptions' stamp: 'LMR 6/11/2023 22:36:35'!
canNotCheckoutWithExpiredCard
	
	^'Can not checkout with an expired credit card'.! !

!Checkout class methodsFor: 'error descriptions' stamp: 'LMR 6/12/2023 15:14:41'!
cardNameIsTooLongErrorDescription
	
	^'Credit card name is too long'.! !

!Checkout class methodsFor: 'error descriptions' stamp: 'LMR 6/11/2023 21:46:57'!
emptyCartErrorDescription
	
	^'Can not checkout an empty cart'.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'name creditCardNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'LMR 6/11/2023 21:44:57'!
initializeName: aName number: aCreditCardNumber expirationDate: aGregorianMonthOfYear 
	
	name := aName.
	creditCardNumber := aCreditCardNumber.
	expirationDate := aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'number' stamp: 'LMR 6/12/2023 00:32:05'!
number

	^creditCardNumber.! !


!CreditCard methodsFor: 'testing' stamp: 'LMR 6/12/2023 00:20:28'!
has16DigitNumber

	^creditCardNumber size = 16.! !

!CreditCard methodsFor: 'testing' stamp: 'LMR 6/11/2023 22:25:59'!
hasEmptyName

	^name isEmpty.! !

!CreditCard methodsFor: 'testing' stamp: 'LMR 6/12/2023 00:15:38'!
isExpired

	^expirationDate < GregorianMonthOfYear current.! !

!CreditCard methodsFor: 'testing' stamp: 'LMR 6/12/2023 15:18:01'!
nameExceedsMaximumLength

	^name size > 30.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LMR 6/11/2023 21:43:52'!
name: aName number: aCreditCardNumber expirationDate: aGregorianMonthOfYear 
	
	^self new initializeName: aName number: aCreditCardNumber expirationDate: aGregorianMonthOfYear.! !


!classDefinition: #MockMerchantProcessor category: 'TusLibros'!
Object subclass: #MockMerchantProcessor
	instanceVariableNames: 'cardFunds stolenCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockMerchantProcessor methodsFor: 'initialization' stamp: 'LMR 6/12/2023 00:49:23'!
initialize

	cardFunds := Dictionary new.
	cardFunds at: '1234567890123456' put: 500.
	cardFunds at: '1234567890123457' put: 500.
	cardFunds at: '1034567890123456' put: 5.
	cardFunds at: '1204567890123456' put: 250.	
	stolenCards :=  OrderedCollection with: '1204567890123456'.! !


!MockMerchantProcessor methodsFor: 'debit' stamp: 'LMR 6/12/2023 00:49:47'!
debit: anAmount fromCard: aCreditCard

	(stolenCards includes: aCreditCard number) ifTrue: [self error: self class stolenCardErrorDescription].
	(anAmount > (cardFunds at: aCreditCard number)) ifTrue: [self error: self class insufficientFundsErrorDescription].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockMerchantProcessor class' category: 'TusLibros'!
MockMerchantProcessor class
	instanceVariableNames: ''!

!MockMerchantProcessor class methodsFor: 'error descriptions' stamp: 'LMR 6/11/2023 23:31:19'!
insufficientFundsErrorDescription

	^'Insufficient funds for purchase'.! !

!MockMerchantProcessor class methodsFor: 'error descriptions' stamp: 'LMR 6/12/2023 00:40:36'!
stolenCardErrorDescription

	^'Stolen card'.! !
