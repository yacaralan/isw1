!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/15/2023 20:19:28'!
test01EmptyPortfolioHasBalance0

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:29:06'!
test02PortfolioWithOneAccountHasBalanceEqualsToThatAccount

	|portfolio account|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio add: account.

	self assert: 100 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:29:45'!
test03PortfolioWithMultipleAccountsHasBalanceEqualsToThose

	|portfolio account account2 |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	
	portfolio add: account.
	portfolio add: account2 .

	self assert: 200 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:29:56'!
test04PortfolioWithMultipleAccountsAndPortfolioHasBalanceEqualsToThose

	|portfolio account portfolio2 account2|
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 100 on: account2.
	
	portfolio2 add: account2.
	portfolio add: account.
	portfolio add: portfolio2 .

	self assert: 200 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:04:20'!
test05EmptyPortfolioHasNoTransactionRegistered
	
	| account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.

	self deny:(Portfolio new hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:30:04'!
test06PortfolioWithMultipleTransactionsOnAccountHasThemRegistered
	
	|portfolio account account2 deposit deposit2 |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	deposit2 := Deposit register: 100 on: account2.
	
	portfolio add: account.
	portfolio add: account2 .

	self assert:(portfolio hasRegistered: deposit).
	self assert:(portfolio hasRegistered: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:30:12'!
test07PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemRegistered
	
	|portfolio portfolio2 account account2 deposit deposit2 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	deposit2 := Deposit register: 100 on: account2.
	
	portfolio2 add: account2.
	portfolio add: account.
	portfolio add: portfolio2  .

	self assert:(portfolio hasRegistered: deposit).
	self assert:(portfolio hasRegistered: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:05:18'!
test08EmptyPortfolioHasNoTransaction
	

	self assert: (Portfolio new transactions) isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:30:19'!
test09PortfolioWithMultipleTransactionsOnAccountHasThemInTransactions
	
	|portfolio account account2 deposit deposit2 portfolioTransactions |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	deposit2 := Deposit register: 100 on: account2.
	
	portfolio add: account.
	portfolio add: account2.

	portfolioTransactions := portfolio transactions.
	
	self assert:(portfolioTransactions includes: deposit).
	self assert:(portfolioTransactions includes: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:30:26'!
test10PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemInTransactions
	
	|portfolio portfolio2 account account2 deposit deposit2 portfolioTransactions |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	deposit2 := Deposit register: 100 on: account2.
	
	portfolio2 add: account2.
	portfolio add: account.
	portfolio add: portfolio2  .

	portfolioTransactions := portfolio transactions.
	
	self assert:(portfolioTransactions includes: deposit).
	self assert:(portfolioTransactions includes: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:47:12'!
test11CantAddAnAccountToAPortfolioMoreThanOnce
	|portfolio account|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio add: account.

	self should: [portfolio add: account] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: Portfolio duplicatedAccountErrorDescription] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/18/2023 00:58:00'!
test12CantAddAnAccountToAPortfolioMoreThanOnceWithASubPortfolioThatContainsIt
	|portfolio portfolio2 account|
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio2 add: account.
	portfolio add: portfolio2.

	self should: [portfolio add: account] 
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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'add' stamp: 'AlYac 5/18/2023 00:52:34'!
add: anAccount 
	
	(accounts includes: anAccount) ifTrue: [self error: self class duplicatedAccountErrorDescription].
	accounts add: anAccount ! !


!Portfolio methodsFor: 'initialization' stamp: 'AlYac 5/18/2023 00:27:28'!
initialize
	
	accounts := OrderedCollection new.
	! !


!Portfolio methodsFor: 'transactions' stamp: 'AlYac 5/18/2023 00:32:41'!
transactions
	
	^accounts inject: OrderedCollection new into: [:transactions :anAccount | transactions , anAccount transactions]! !


!Portfolio methodsFor: 'balance' stamp: 'AlYac 5/18/2023 00:28:37'!
balance
	
	^ accounts sum: [:anAccount| anAccount balance] ifEmpty: [0] ! !


!Portfolio methodsFor: 'testing' stamp: 'AlYac 5/18/2023 00:31:13'!
hasRegistered: aTransaction 
	
	^ accounts anySatisfy: [:anAccount|anAccount hasRegistered: aTransaction]! !

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
