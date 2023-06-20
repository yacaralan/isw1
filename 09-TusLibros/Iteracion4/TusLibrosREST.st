!classDefinition: #TusLibrosClientTestWindow category: 'TusLibrosREST'!
SystemWindow subclass: #TusLibrosClientTestWindow
	instanceVariableNames: 'cartIdsListMorph booksCatalogListMorph cartContentListMorph addToCartButtonMorph listCartButtonMorph selectedCartLabelMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosClientTestWindow methodsFor: 'events' stamp: 'LMR 6/16/2023 01:55:40'!
informBook: bookIsbn addedToCart: cartId

	self inform: bookIsbn,' added to CartId: ', cartId asString
	
! !

!TusLibrosClientTestWindow methodsFor: 'events' stamp: 'LMR 6/20/2023 16:47:24'!
informError: anErrorDescription

	self inform: anErrorDescription.	! !

!TusLibrosClientTestWindow methodsFor: 'events' stamp: 'LMR 6/16/2023 01:55:40'!
refreshCartButtonsLabels: anIndex

	self refreshButton: listCartButtonMorph withLabel: 'List CartId: '  onIndex: anIndex.
	self refreshButton: addToCartButtonMorph withLabel: 'Add to CartId: '  onIndex: anIndex.
	
	
	! !

!TusLibrosClientTestWindow methodsFor: 'events' stamp: 'LMR 6/16/2023 01:55:40'!
refreshCurrentSelectedCartContent: cartId

	cartContentListMorph updateList.
	selectedCartLabelMorph contents: 'Books in CartId: ', cartId
	
	
	! !

!TusLibrosClientTestWindow methodsFor: 'events' stamp: 'LMR 6/16/2023 01:55:40'!
refreshListOfCartIds

	cartIdsListMorph updateList
	! !


!TusLibrosClientTestWindow methodsFor: 'private' stamp: 'LMR 6/16/2023 01:55:40'!
refreshButton: aButton withLabel: aLabel onIndex: anIndex

	| newLabel |

	newLabel := aLabel.
	(anIndex ~= 0) ifTrue: [newLabel := newLabel,  (self model cartIds at: anIndex) asString].
	aButton label: newLabel.
	aButton morphHeight: self heightOfButtons.
	aButton redrawNeeded 
	
	! !


!TusLibrosClientTestWindow methodsFor: 'GUI building' stamp: 'LMR 6/16/2023 01:55:40'!
build1stRow

	| createCartButtonMorph firstRowLayoutMorph |
	
	createCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #createCart label: 'Create Cart'.	
	addToCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #addToCart label: 'Add To Cart'.	
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: createCartButtonMorph;
	addMorph: self build2ndColumn1stRow;
	addMorph: self build3rdColumn1stRow;
	addMorph:  addToCartButtonMorph.
	
	
	^firstRowLayoutMorph.! !

!TusLibrosClientTestWindow methodsFor: 'GUI building' stamp: 'LMR 6/16/2023 01:55:40'!
build2ndColumn1stRow

	| secondColumnLayoutMorphOfFirstRow |
	
	cartIdsListMorph := PluggableListMorph model: self model listGetter: #cartIds indexGetter: #cartIdsIndex indexSetter: #cartIdsIndex:.
	cartIdsListMorph  borderColor: Color lightBlue; borderWidth: 1; morphWidth:300.
		
	secondColumnLayoutMorphOfFirstRow := LayoutMorph newColumn.
	secondColumnLayoutMorphOfFirstRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Carts Created');
	addMorph: cartIdsListMorph.
	
	secondColumnLayoutMorphOfFirstRow layoutSpec fixedWidth: 390.
	cartIdsListMorph layoutSpec proportionalWidth: 1.
	cartIdsListMorph layoutSpec proportionalHeight: 1.
		
	^secondColumnLayoutMorphOfFirstRow.! !

!TusLibrosClientTestWindow methodsFor: 'GUI building' stamp: 'LMR 6/16/2023 01:55:40'!
build2ndColumn2ndRow

	| secondColumnLayoutMorphOfSecondRow |

	cartContentListMorph := PluggableListMorph model: self model listGetter: #cartContent indexGetter: nil indexSetter: nil.
	cartContentListMorph  borderColor: Color lightBlue; borderWidth: 1; morphWidth:300.
	
	selectedCartLabelMorph := LabelMorph contents:'Books in CartId: '.
		
	secondColumnLayoutMorphOfSecondRow := LayoutMorph newColumn.
	secondColumnLayoutMorphOfSecondRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: selectedCartLabelMorph;
	addMorph: cartContentListMorph.
	
	secondColumnLayoutMorphOfSecondRow layoutSpec fixedWidth: 390.
	cartContentListMorph layoutSpec proportionalWidth: 1.
	cartContentListMorph layoutSpec proportionalHeight: 1.
		
	^secondColumnLayoutMorphOfSecondRow.! !

!TusLibrosClientTestWindow methodsFor: 'GUI building' stamp: 'LMR 6/16/2023 01:55:40'!
build2ndRow

	| secondRowLayoutMorph |

	listCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #listCart label: 'List CartId: '.	
	
	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: listCartButtonMorph;
	addMorph: self build2ndColumn2ndRow.
	
	^secondRowLayoutMorph

		! !

!TusLibrosClientTestWindow methodsFor: 'GUI building' stamp: 'LMR 6/16/2023 01:55:40'!
build3rdColumn1stRow

	| thirdColumnLayoutMorphOfFirstRow |
	
	booksCatalogListMorph := PluggableListMorph model: self model listGetter: #booksCatalog indexGetter: #booksCatalogIndex indexSetter: #booksCatalogIndex:.
	booksCatalogListMorph borderColor: Color lightBlue; borderWidth: 1; morphWidth:300.
		
	thirdColumnLayoutMorphOfFirstRow  := LayoutMorph newColumn.
	thirdColumnLayoutMorphOfFirstRow  separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Book Catalog');
	addMorph: booksCatalogListMorph.
	
	thirdColumnLayoutMorphOfFirstRow layoutSpec fixedWidth: 390.
		
	^thirdColumnLayoutMorphOfFirstRow.! !

!TusLibrosClientTestWindow methodsFor: 'GUI building' stamp: 'LMR 6/16/2023 01:55:40'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self build1stRow;
	addMorph: self build2ndRow.
	! !

!TusLibrosClientTestWindow methodsFor: 'GUI building' stamp: 'LMR 6/16/2023 01:55:40'!
defaultExtent

	^ 1035@485
	! !

!TusLibrosClientTestWindow methodsFor: 'GUI building' stamp: 'LMR 6/16/2023 01:55:40'!
heightOfButtons

	^ 66! !


!TusLibrosClientTestWindow methodsFor: 'initialization' stamp: 'LMR 6/20/2023 17:12:29'!
initializeWith: aTitle

	self setLabel: aTitle.
	self model: (TusLibrosClientTestWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #newCartIdArrived send: #refreshListOfCartIds to: self.		
	self model when: #selectedCartChanged send: #refreshCartButtonsLabels: to: self.	
	self model when: #bookAddedToCart send: #informBook:addedToCart: to: self.
	self model when: #newCurrentSelectedCartContentArrived send: #refreshCurrentSelectedCartContent: to: self.
	self model when: #errorArrisen send: #informError: to: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientTestWindow class' category: 'TusLibrosREST'!
TusLibrosClientTestWindow class
	instanceVariableNames: ''!

!TusLibrosClientTestWindow class methodsFor: 'instance creation' stamp: 'LMR 6/20/2023 17:14:09'!
open
	
	^self new initializeWith: 'TusLibros Client Test Window'.! !


!classDefinition: #TusLibrosClientRestInterface category: 'TusLibrosREST'!
Object subclass: #TusLibrosClientRestInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosClientRestInterface methodsFor: 'requests' stamp: 'LMR 6/20/2023 18:45:47'!
add: quantity of: bookIsbn toCartIdentifiedAs: cartId

	| fieldDict |
	
	fieldDict := Dictionary newFromPairs: {'cartId'. cartId. 'bookIsbn'. bookIsbn. 'bookQuantity'. quantity}.		
	
	^self httpRequest: 'addToCart'
		withFields: fieldDict
		ifSuccessDo: [:resp |
			(WebUtils jsonDecode: ((resp content) readStream))
		].! !

!TusLibrosClientRestInterface methodsFor: 'requests' stamp: 'LMR 6/20/2023 18:45:52'!
createCartFor: aUser password: aPassword

	| fieldDict |
	
	fieldDict := Dictionary newFromPairs: {'clientId'. aUser. 'password'. aPassword}.		
	
	^self httpRequest: 'createCart'
		withFields: fieldDict
		ifSuccessDo: [:resp |
			(WebUtils jsonDecode: ((resp content) readStream))
		].! !

!TusLibrosClientRestInterface methodsFor: 'requests' stamp: 'LMR 6/20/2023 18:42:07'!
httpRequest: requestPath withFields: fieldDict ifSuccessDo: successClosure

	| resp |
	
	resp := WebClient htmlSubmit: (self url,'/', requestPath) fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^successClosure value: resp]
		ifFalse:[^self error: resp content].! !

!TusLibrosClientRestInterface methodsFor: 'requests' stamp: 'LMR 6/20/2023 18:45:55'!
listCart: cartId

	| fieldDict |
	
	fieldDict := Dictionary newFromPairs: {'cartId'. cartId. }.		
	
	^self httpRequest: 'listCart'
		withFields: fieldDict
		ifSuccessDo: [:resp | 
			(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection
		].! !


!TusLibrosClientRestInterface methodsFor: 'initialization' stamp: 'LMR 6/16/2023 01:55:40'!
port

	^port ifNil: [port:=9999].! !

!TusLibrosClientRestInterface methodsFor: 'initialization' stamp: 'LMR 6/16/2023 01:55:40'!
url

	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosClientTestWindowModel category: 'TusLibrosREST'!
Object subclass: #TusLibrosClientTestWindowModel
	instanceVariableNames: 'cartIds selectedCartIdsIndex selectedBookCatalogIndex currentSelectedCartContent restInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosClientTestWindowModel methodsFor: 'accessing' stamp: 'LMR 6/16/2023 01:55:41'!
selectedBook

	^self booksCatalog at: selectedBookCatalogIndex! !

!TusLibrosClientTestWindowModel methodsFor: 'accessing' stamp: 'LMR 6/16/2023 01:55:41'!
selectedCartId

	^self cartIds at: selectedCartIdsIndex! !


!TusLibrosClientTestWindowModel methodsFor: 'testing' stamp: 'LMR 6/16/2023 01:55:41'!
areCartIdAndBookSelected

	^selectedCartIdsIndex  ~= 0 and: [selectedBookCatalogIndex  ~= 0]! !

!TusLibrosClientTestWindowModel methodsFor: 'testing' stamp: 'LMR 6/16/2023 01:55:41'!
isCartIdSelected

	^selectedCartIdsIndex ~= 0! !


!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'LMR 6/16/2023 01:55:41'!
booksCatalog

	^self defaultCatalog keys! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'LMR 6/16/2023 01:55:41'!
booksCatalogIndex

	^selectedBookCatalogIndex! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'LMR 6/16/2023 01:55:41'!
booksCatalogIndex: anIndex

	selectedBookCatalogIndex  := anIndex! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'LMR 6/16/2023 01:55:41'!
cartContent

	^currentSelectedCartContent! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'LMR 6/16/2023 01:55:41'!
cartIds

	^cartIds! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'LMR 6/16/2023 01:55:41'!
cartIdsIndex

	^selectedCartIdsIndex! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'LMR 6/16/2023 01:55:41'!
cartIdsIndex: anIndex

	selectedCartIdsIndex  := anIndex. 
		
	self triggerEvent: #selectedCartChanged with: selectedCartIdsIndex
	! !


!TusLibrosClientTestWindowModel methodsFor: 'buttonSelectors' stamp: 'LMR 6/20/2023 17:26:52'!
addToCart

	| cartId bookIsbn |

	self forkAndInformOnError: [
		(self areCartIdAndBookSelected) ifTrue:[
			cartId := self selectedCartId.
			bookIsbn := self selectedBook.
			restInterface add: 1 of: bookIsbn toCartIdentifiedAs: cartId.
			self triggerEvent: #bookAddedToCart withArguments: (Array with: bookIsbn with: cartId).
		]
	]! !

!TusLibrosClientTestWindowModel methodsFor: 'buttonSelectors' stamp: 'LMR 6/20/2023 17:26:48'!
createCart

	| newCartId |
	
	self forkAndInformOnError: [
		newCartId := restInterface createCartFor: 'hernan' password: 'smalltalk'.
		cartIds add: newCartId.
		self triggerEvent: #newCartIdArrived.
	].
	! !

!TusLibrosClientTestWindowModel methodsFor: 'buttonSelectors' stamp: 'LMR 6/20/2023 17:27:22'!
listCart

	| cartId |
	
	self forkAndInformOnError: [
		(self isCartIdSelected) ifTrue:[
			cartId := self selectedCartId.
			currentSelectedCartContent := restInterface listCart: cartId.
			self triggerEvent: #newCurrentSelectedCartContentArrived with: cartId.
		].
	]! !


!TusLibrosClientTestWindowModel methodsFor: 'concurrency and error handling' stamp: 'LMR 6/20/2023 17:14:17'!
forkAndInformOnError: aClosure

	[
		aClosure
			on: Error
			do: [:anError | 
				self triggerEvent: #errorArrisen withArguments: (Array with: anError messageText).
			]	
	] fork.! !


!TusLibrosClientTestWindowModel methodsFor: 'initialization' stamp: 'LMR 6/16/2023 01:55:41'!
defaultCatalog 

	^Dictionary new
		at: 'GreenBook' put: 10*dollar;
		at: 'BlueBook' put: 15*dollar;
		at: 'MartinFierro' put: 350*peso;
		yourself! !

!TusLibrosClientTestWindowModel methodsFor: 'initialization' stamp: 'LMR 6/16/2023 01:55:41'!
initialize

	cartIds := OrderedCollection new.
	currentSelectedCartContent := OrderedCollection new.
	selectedCartIdsIndex := 0.
	selectedBookCatalogIndex := 0.
	restInterface := TusLibrosClientRestInterface new.! !


!classDefinition: #TusLibrosServerRestInterface category: 'TusLibrosREST'!
Object subclass: #TusLibrosServerRestInterface
	instanceVariableNames: 'systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'LMR 6/16/2023 01:55:41'!
initializeOn: aTusLibrosSystemFacade 
	
	systemFacade := aTusLibrosSystemFacade.! !


!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'LMR 6/16/2023 01:55:42'!
answer: aBlock to: aRequest 

	| response |
	
	[ response := aBlock value.
	aRequest send200Response: (WebUtils jsonEncode: (response))]
		on: Error
		do: [ :anError | aRequest send400Response: anError messageText ]! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'LMR 6/16/2023 01:55:41'!
bookIsbnFrom: requestFields

	^ requestFields at: 'bookIsbn'! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'LMR 6/16/2023 01:55:41'!
bookQuantityFrom: requestFields

	^ (requestFields at: 'bookQuantity') asNumber! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'LMR 6/16/2023 01:55:41'!
cartIdFrom: requestFields

	^ (requestFields at: 'cartId') asNumber! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'LMR 6/16/2023 01:55:42'!
clientIdFrom: requestFields

	^ requestFields at: 'clientId'! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'LMR 6/16/2023 01:55:41'!
passwordFrom: requestFields

	^ requestFields at: 'password'! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'LMR 6/16/2023 01:55:41'!
withFieldsOf: aRequest do: aBlock

	[ aBlock value: aRequest fields ]
		on: Error
		do: [ :anError | aRequest 
			sendResponseCode: 400 
			content: ('Invalid request: ', anError messageText) asUtf8Bytes
			type: 'text/plain; charset=utf-8'
			close: true ]! !


!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'LMR 6/20/2023 14:35:22'!
addToCart: aRequest

	| bookIsbn cartId quantity |
	(Delay forSeconds: 3) wait.
	
	self withFieldsOf: aRequest do: [ :requestFields |
		cartId := self cartIdFrom: requestFields.
		bookIsbn := self bookIsbnFrom: requestFields.
		quantity := self bookQuantityFrom: requestFields].
	
	self 
		answer: [
			systemFacade add: quantity of: bookIsbn toCartIdentifiedAs: cartId.
			'OK' ]
		to: aRequest.! !

!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'LMR 6/16/2023 01:55:42'!
checkOutCart: aRequest

	| cartId creditCardNumber creditCardOwner creditCartExpirationDate creditCartExpirationDateString transactionId |
	
	self withFieldsOf: aRequest do: [ :requestFields |
		cartId := self cartIdFrom: requestFields.
		creditCardNumber := requestFields at: 'ccn'.
		creditCartExpirationDateString := requestFields at: 'cced'.
		creditCartExpirationDate := Month 
			month: (creditCartExpirationDateString first: 2) asNumber 
			year: (creditCartExpirationDateString last: 4) asNumber.
		creditCardOwner := requestFields at: 'cco' ].
	
	self 
		answer: [
			transactionId := systemFacade 
					checkOutCartIdentifiedAs: cartId 
					withCreditCardNumbered: creditCardNumber 
					ownedBy: creditCardOwner 
					expiringOn: creditCartExpirationDate. 
			transactionId printString ]
		to: aRequest ! !

!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'LMR 6/16/2023 01:55:42'!
createCart: aRequest

	| clientId password |

	(Delay forSeconds: 1) wait.
	
	self withFieldsOf: aRequest do: [ :requestFields |
		clientId := self clientIdFrom: requestFields.
		password := self passwordFrom: requestFields ].
	
	self 
		answer: [ | cartId | 
			cartId := systemFacade createCartFor: clientId authenticatedWith: password.
			cartId printString ]
		to: aRequest ! !

!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'LMR 6/20/2023 17:16:27'!
listCart: aRequest

	| cartId |

	(Delay forSeconds: 10) wait.
	
	self withFieldsOf: aRequest do: [ :requestFields |
		cartId := self cartIdFrom: requestFields ].
	
	self 
		answer: [(systemFacade listCartIdentifiedAs: cartId) asArray]
		to: aRequest 
! !

!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'LMR 6/16/2023 01:55:42'!
listPurchases: aRequest

	| clientId password purchases response |
	
	self withFieldsOf: aRequest do: [ :requestFields |
		clientId := self clientIdFrom: requestFields.
		password := self passwordFrom: requestFields ].
	
	self 
		answer: [ | soldItems total |
			purchases := systemFacade listPurchasesOf: clientId authenticatingWith: password.
			soldItems := purchases first.
			total := purchases second.
			response := String streamContents: [:stream | 
				soldItems keysAndValuesDo: [ :isbn :amount |
					stream nextPutAll: isbn; nextPut: $|; print: amount; nextPut: $| ].
				stream print: total ].
			response ]
		to: aRequest ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerRestInterface class' category: 'TusLibrosREST'!
TusLibrosServerRestInterface class
	instanceVariableNames: ''!

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'LMR 6/16/2023 01:55:42'!
createSalesBook
	
	^OrderedCollection new! !

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'LMR 6/16/2023 01:55:42'!
defaultCatalog 
	
	^Dictionary new
		at: 'GreenBook' put: 10*dollar;
		at: 'BlueBook' put: 15*dollar;
		at: 'MartinFierro' put: 350*peso;
		yourself! !

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'LMR 6/16/2023 01:55:42'!
defaultMerchantProcessor 
	
	^DefaultMerchantProcessor new! !

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'LMR 6/16/2023 01:55:42'!
defaultSystem

	| clock systemFacade |
	
	clock := RealTimeClock new.
	systemFacade := TusLibrosSystemFacade 
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf: self defaultCatalog 
		registeringOn: self createSalesBook
		debitingThrought: self defaultMerchantProcessor 
		measuringTimeWith: clock.

	^systemFacade ! !

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'LMR 6/16/2023 01:55:42'!
validUsersAndPasswords 
	
	^Dictionary new
		at: 'hernan' put: 'smalltalk';
		at: 'maximo' put: 'ruby';
		yourself! !


!TusLibrosServerRestInterface class methodsFor: 'instance creation' stamp: 'LMR 6/16/2023 01:55:42'!
on: aTusLibrosSystemFacade 

	^self new initializeOn: aTusLibrosSystemFacade ! !


!TusLibrosServerRestInterface class methodsFor: 'installation' stamp: 'LMR 6/16/2023 01:55:42'!
installForDefaultSystem

	"self installForDefaultSystem"
	
	| server port interface |
	
	interface := self on: self defaultSystem.
	
	"Esto es para poder acceder a la interface de manera global - Hernan"
	Smalltalk at: #CurrentTusLibrosRestInterface put: interface.
	
	port := 9999.
	server := WebServer reset default.
	server listenOn: port.
	server 
		addService: '/createCart' 
		action: [:request | interface createCart: request ].
	server 
		addService: '/addToCart' 
		action: [:request | interface addToCart: request ].
	server
		addService: '/listCart' 
		action: [:request | interface listCart: request ].
	server
		addService: '/checkOutCart' 
		action: [:request | interface checkOutCart: request ].
	server
		addService: '/listPurchases' 
		action: [:request | interface listPurchases: request ].
	server useDebugErrorHandler ! !


!classDefinition: #DefaultMerchantProcessor category: 'TusLibrosREST'!
ProtoObject subclass: #DefaultMerchantProcessor
	instanceVariableNames: 'transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!DefaultMerchantProcessor methodsFor: 'debit' stamp: 'LMR 6/16/2023 01:55:39'!
debit: anAmount from: aCreditCard 

	transactionId := transactionId + 1.
	^transactionId! !


!DefaultMerchantProcessor methodsFor: 'initialization' stamp: 'LMR 6/16/2023 01:55:39'!
initialize

	super initialize.
	transactionId := 0! !


!classDefinition: #RealTimeClock category: 'TusLibrosREST'!
ProtoObject subclass: #RealTimeClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!RealTimeClock methodsFor: 'time' stamp: 'LMR 6/16/2023 01:55:39'!
now

	^DateAndTime now! !

!RealTimeClock methodsFor: 'time' stamp: 'LMR 6/16/2023 01:55:39'!
today

	^Date today! !
