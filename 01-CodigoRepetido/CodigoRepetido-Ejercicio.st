!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'Assertions' stamp: 'a 4/11/2023 00:35:07'!
assertThatCustomerBook: aCustomerBook activeCustomersAmountEquals: activeCustomerAmount suspendedCustomersAmountEquals: suspendedCustomerAmount totalCustomersAmountEquals: totalCustomerAmount andCheck: aBoolean 
	
	self assert: activeCustomerAmount equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCustomerAmount equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalCustomerAmount equals: aCustomerBook numberOfCustomers.
	self assert: aBoolean! !

!CustomerBookTest methodsFor: 'Assertions' stamp: 'a 4/11/2023 00:33:48'!
assertThatCustomerBook: aCustomerBook activeCustomersAmountEquals: activeCustomerAmount suspendedCustomersAmountEquals: suspendedCustomerAmount totalCustomersAmountEquals: totalCustomerAmount andDeny: aBoolean 
	
	self assertThatCustomerBook: aCustomerBook 
	activeCustomersAmountEquals: activeCustomerAmount  
	suspendedCustomersAmountEquals: suspendedCustomerAmount  
	totalCustomersAmountEquals:  totalCustomerAmount 
	andCheck: aBoolean not! !

!CustomerBookTest methodsFor: 'Assertions' stamp: 'a 4/11/2023 00:09:15'!
assertThatExecution: aClosure failsOn: errorClass andChecksThat: assertionClosure
	[aClosure value.
	self fail]
		on: errorClass 
		do: assertionClosure! !

!CustomerBookTest methodsFor: 'Assertions' stamp: 's 4/10/2023 21:49:28'!
assertThatExecutionTimeInMilliseconds: aClosure shouldNotExceed: anAmountOfMilliseconds
	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: millisecondsAfterRunning-millisecondsBeforeRunning < anAmountOfMilliseconds ! !

!CustomerBookTest methodsFor: 'Assertions' stamp: 'a 4/11/2023 01:01:38'!
theCustomerBook: aCustomerBook hasOnly: aName

	^[self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aName)]! !


!CustomerBookTest methodsFor: 'testing' stamp: 's 4/10/2023 21:49:46'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	
	self assertThatExecutionTimeInMilliseconds: [customerBook addCustomerNamed: 'John Lennon'] shouldNotExceed: 50 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 's 4/10/2023 21:50:45'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.

	
	self assertThatExecutionTimeInMilliseconds: [customerBook removeCustomerNamed: paulMcCartney] shouldNotExceed:100 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 4/11/2023 00:00:57'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assertThatExecution: [customerBook addCustomerNamed: ''] 
		failsOn: Error 
		andChecksThat: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 4/11/2023 01:03:56'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThatExecution: [customerBook removeCustomerNamed: 'Paul McCartney'] 
		failsOn: NotFound 
		andChecksThat: (self theCustomerBook: customerBook hasOnly: johnLennon )
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 4/11/2023 00:31:21'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatCustomerBook: customerBook 
	activeCustomersAmountEquals: 0  
	suspendedCustomersAmountEquals: 1  
	totalCustomersAmountEquals:  1 
	andCheck: (customerBook includesCustomerNamed: paulMcCartney)
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 4/11/2023 00:32:21'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.

	self assertThatCustomerBook: customerBook 
	activeCustomersAmountEquals: 0  
	suspendedCustomersAmountEquals: 0  
	totalCustomersAmountEquals:  0 
	andDeny: (customerBook includesCustomerNamed: paulMcCartney)


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 4/11/2023 01:05:45'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThatExecution: [ customerBook suspendCustomerNamed: 'George Harrison'] 
	failsOn: CantSuspend 
	andChecksThat: (self theCustomerBook: customerBook hasOnly: johnLennon )
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 4/11/2023 01:02:56'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.

	self assertThatExecution: [ customerBook suspendCustomerNamed: johnLennon] 
	failsOn: CantSuspend 
	andChecksThat: (self theCustomerBook: customerBook hasOnly: johnLennon )
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'a 4/11/2023 01:16:05'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'a 4/11/2023 01:27:33'!
remove: aName from: anOrderedCollection

	1 to: anOrderedCollection size do: 
		[ :index |
			aName = (anOrderedCollection at: index)
				ifTrue: [
					anOrderedCollection removeAt: index.
					^ aName 
				] 
		].! !

!CustomerBook methodsFor: 'customer management' stamp: 'LMR 4/12/2023 15:06:56'!
removeCustomerNamed: aName 

	(self includesCustomerNamed: aName) ifFalse: [^ NotFound signal.].
	
	self remove: aName from: active.

	self remove: aName from: suspended. 

	^aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
