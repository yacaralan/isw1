!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/15/2023 20:19:28'!
test01EmptyPortfolioHasBalance0

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'sdaasd 5/15/2023 20:52:41'!
test02PortfolioWithOneAccountHasBalanceEqualsToThatAccount

	|portfolio account|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio addAccount: account.

	self assert: 100 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'sdaasd 5/15/2023 21:05:53'!
test03PortfolioWithMultipleAccountsHasBalanceEqualsToThose

	|portfolio account account2 |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	
	portfolio addAccount: account.
	portfolio addAccount: account2 .

	self assert: 200 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'sdaasd 5/15/2023 21:33:04'!
test04PortfolioWithMultipleAccountsAndPortfolioHasBalanceEqualsToThose

	|portfolio account portfolio2 account2|
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 100 on: account2.
	
	portfolio2 addAccount: account2.
	portfolio addAccount: account.
	portfolio addPortfolio: portfolio2 .

	self assert: 200 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'sdaasd 5/15/2023 21:20:27'!
test05EmptyPortfolioHasNoTransaction
	
	| account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.

	self deny:(Portfolio new hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'sdaasd 5/15/2023 21:27:54'!
test06PortfolioWithMultipleTransactionsOnAccountHasThemRegistered
	
	|portfolio account account2 deposit deposit2 |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	deposit2 := Deposit register: 100 on: account2.
	
	portfolio addAccount: account.
	portfolio addAccount: account2 .

	self assert:(portfolio hasRegistered: deposit).
	self assert:(portfolio hasRegistered: deposit2)! !

!PortfolioTest methodsFor: 'tests' stamp: 'sdaasd 5/15/2023 21:33:45'!
test07PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemRegistered
	
	|portfolio portfolio2 account account2 deposit deposit2 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	deposit2 := Deposit register: 100 on: account2.
	
	portfolio2 addAccount: account2.
	portfolio addAccount: account.
	portfolio addPortfolio: portfolio2  .

	self assert:(portfolio hasRegistered: deposit).
	self assert:(portfolio hasRegistered: deposit2)! !


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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios hasRegistered'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'sdaasd 5/15/2023 21:07:54'!
accountsBalance

	^ accounts sum: [:anAccount| anAccount balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'balance' stamp: 'sdaasd 5/15/2023 21:08:37'!
balance
	
	^ self accountsBalance + self portfoliosBalance ! !

!Portfolio methodsFor: 'balance' stamp: 'sdaasd 5/15/2023 21:08:25'!
portfoliosBalance

	^ portfolios sum: [:aPortfolio| aPortfolio balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'add' stamp: 'sdaasd 5/15/2023 21:00:09'!
addAccount: account 
	
	accounts add: account ! !

!Portfolio methodsFor: 'add' stamp: 'sdaasd 5/15/2023 21:06:38'!
addPortfolio: aPortfolio 
	
	portfolios add: aPortfolio! !


!Portfolio methodsFor: 'initialization' stamp: 'sdaasd 5/15/2023 21:23:32'!
initialize
	
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	hasRegistered := false! !


!Portfolio methodsFor: 'registered' stamp: 'sdaasd 5/15/2023 21:37:19'!
hasRegistered: aTransaction 
	
	^ (self hasRegisteredInAccounts: aTransaction) or: [self  hasRegisteredInPortfolio: aTransaction]! !

!Portfolio methodsFor: 'registered' stamp: 'sdaasd 5/15/2023 21:35:59'!
hasRegisteredInAccounts: aTransaction

	^ accounts anySatisfy: [:anAccount|anAccount hasRegistered: aTransaction]! !

!Portfolio methodsFor: 'registered' stamp: 'sdaasd 5/15/2023 21:36:42'!
hasRegisteredInPortfolio: aTransaction

	^ portfolios anySatisfy: [:aPortfolio|aPortfolio hasRegistered: aTransaction]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'sdaasd 5/15/2023 20:48:35'!
new
	
	^self basicNew initialize! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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
