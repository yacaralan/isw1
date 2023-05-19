!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'newPortfolio anAccount anotherAccount anotherNewPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'set up' stamp: 'AlYac 5/18/2023 18:14:16'!
setUp

	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	newPortfolio := Portfolio new.
	anotherNewPortfolio := Portfolio new.! !


!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:06:47'!
test01EmptyPortfolioHasBalance0

	self assert: 0 equals: newPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:11:48'!
test02PortfolioWithOneAccountHasBalanceEqualsToThatAccount

	Deposit register: 100 on: anAccount .
	
	newPortfolio add: anAccount .

	self assert: 100 equals: newPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:13:17'!
test03PortfolioWithMultipleAccountsHasBalanceEqualsToThose

	Deposit register: 100 on: anAccount .
	Deposit register: 100 on: anotherAccount .
	
	newPortfolio add: anAccount .
	newPortfolio add: anotherAccount .

	self assert: 200 equals: newPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:15:44'!
test04PortfolioWithMultipleAccountsAndPortfolioHasBalanceEqualsToThose

	Deposit register: 100 on: anAccount .
	Deposit register: 100 on: anotherAccount .
	
	anotherNewPortfolio add: anotherAccount.
	newPortfolio add: anAccount .
	newPortfolio add: anotherNewPortfolio .

	self assert: 200 equals: newPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:17:05'!
test05EmptyPortfolioHasNoTransactionRegistered
	
	| deposit |
	deposit := Deposit register: 100 on: anAccount.

	self deny: (newPortfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:18:16'!
test06PortfolioWithMultipleTransactionsOnAccountHasThemRegistered
	
	|deposit deposit2|
	
	deposit := Deposit register: 100 on: anAccount .
	deposit2 := Deposit register: 100 on: anotherAccount .
	
	newPortfolio add: anAccount.
	newPortfolio add: anotherAccount.

	self assert:(newPortfolio hasRegistered: deposit).
	self assert:(newPortfolio hasRegistered: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:19:23'!
test07PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemRegistered
	
	|deposit deposit2|
	
	deposit := Deposit register: 100 on: anAccount.
	deposit2 := Deposit register: 100 on: anotherAccount.
	
	anotherNewPortfolio add: anotherAccount.
	newPortfolio add: anAccount.
	newPortfolio add: anotherNewPortfolio.

	self assert:(newPortfolio hasRegistered: deposit).
	self assert:(newPortfolio hasRegistered: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:19:56'!
test08EmptyPortfolioHasNoTransaction
	

	self assert: (newPortfolio transactions) isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:21:15'!
test09PortfolioWithMultipleTransactionsOnAccountHasThemInTransactions
	
	|deposit deposit2 portfolioTransactions|
	deposit := Deposit register: 100 on: anAccount.
	deposit2 := Deposit register: 100 on: anotherAccount.
	
	newPortfolio add: anAccount .
	newPortfolio add: anotherAccount.

	portfolioTransactions := newPortfolio transactions.
	
	self assert:(portfolioTransactions includes: deposit).
	self assert:(portfolioTransactions includes: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:25:40'!
test10PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemInTransactions
	
	|deposit deposit2 portfolioTransactions|
	deposit := Deposit register: 100 on: anAccount.
	deposit2 := Deposit register: 100 on: anotherAccount.
	
	anotherNewPortfolio add: anotherAccount.
	newPortfolio add: anAccount.
	newPortfolio add: anotherNewPortfolio.

	portfolioTransactions := newPortfolio transactions.
	
	self assert:(portfolioTransactions includes: deposit).
	self assert:(portfolioTransactions includes: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 20:55:29'!
test11CantAddAnAccountToAPortfolioMoreThanOnce
	
	newPortfolio add: anotherNewPortfolio .

	self should: [newPortfolio add: anotherNewPortfolio ] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: Portfolio duplicatedAccountErrorDescription] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 18:24:58'!
test12CantAddAnAccountToAPortfolioMoreThanOnceWithASubPortfolioThatContainsIt
	
	anotherNewPortfolio add: anAccount.
	newPortfolio add: anotherNewPortfolio.

	self should: [newPortfolio add: anAccount] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: Portfolio duplicatedAccountErrorDescription] ! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'balance' stamp: 'AlYac 5/18/2023 00:34:03'!
balance
	
	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'AlYac 5/18/2023 00:34:20'!
hasRegistered: aTransaction
	
	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'AlYac 5/18/2023 00:34:43'!
transactions
	
	self subclassResponsibility ! !


!Account methodsFor: 'aux' stamp: 'AlYac 5/18/2023 20:28:36'!
accounts
	
	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'myAccounts allSubAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'add' stamp: 'AlYac 5/18/2023 21:02:45'!
add: anAccount 
	
	anAccount accounts do: [:account | self checkAccountNotDuplicated: account].
	myAccounts add: anAccount.
	allSubAccounts addAll: anAccount accounts.! !


!Portfolio methodsFor: 'initialization' stamp: 'AlYac 5/18/2023 20:58:45'!
initialize
	
	myAccounts := OrderedCollection new.
	allSubAccounts := OrderedCollection with: self.
	! !


!Portfolio methodsFor: 'transactions' stamp: 'AlYac 5/18/2023 21:19:33'!
transactions
	
	^myAccounts inject: OrderedCollection new into: [:transactions :anAccount | transactions , anAccount transactions]! !


!Portfolio methodsFor: 'balance' stamp: 'AlYac 5/18/2023 20:20:30'!
balance
	
	^ myAccounts sum: [:anAccount| anAccount balance] ifEmpty: [0] ! !


!Portfolio methodsFor: 'validations' stamp: 'AlYac 5/18/2023 21:00:17'!
checkAccountNotDuplicated: anAccount

	^ (allSubAccounts anySatisfy: [:subAccount | subAccount = anAccount]) ifTrue: [self error: self class duplicatedAccountErrorDescription]! !


!Portfolio methodsFor: 'aux' stamp: 'AlYac 5/18/2023 20:31:57'!
accounts
	
	^allSubAccounts! !


!Portfolio methodsFor: 'testing' stamp: 'AlYac 5/18/2023 20:20:30'!
hasRegistered: aTransaction 
	
	^ myAccounts anySatisfy: [:anAccount|anAccount hasRegistered: aTransaction]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errors' stamp: 'AlYac 5/18/2023 00:48:39'!
duplicatedAccountErrorDescription

	^ 'That account is already registered!!'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'sdaasd 5/15/2023 20:48:35'!
new
	
	^self basicNew initialize! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'sdaasd 5/15/2023 20:55:57'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'LMR 5/15/2023 20:15:44'!
balance
	
	|balance|
	balance := 0.
	transactions do: [:aTransaction |balance := aTransaction effectOnBalance: balance].
	^balance! !


!ReceptiveAccount methodsFor: 'aux' stamp: 'AlYac 5/18/2023 20:26:49'!
accounts

	^OrderedCollection with: self! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'LMR 5/15/2023 20:05:08'!
effectOnBalance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'LMR 5/15/2023 20:12:22'!
effectOnBalance: aBalance
	
	^aBalance + self value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'LMR 5/15/2023 20:12:37'!
effectOnBalance: aBalance
	
	^aBalance + self value negated! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
