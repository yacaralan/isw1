!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'firstAccount secondAccount firstNewPortfolio secondNewPortfolio thirdNewPortfolio fourthNewPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'set up' stamp: 'LMR 5/22/2023 00:01:28'!
setUp

	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.

	firstNewPortfolio := Portfolio new.
	secondNewPortfolio := Portfolio new.
	thirdNewPortfolio := Portfolio new.
	fourthNewPortfolio := Portfolio new.! !


!PortfolioTest methodsFor: 'assertions' stamp: 'LMR 5/21/2023 22:54:29'!
assertThatPortfolio: aPortfolio canNotAdd: anAccount
	
	self should: [aPortfolio add: anAccount ] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: Portfolio duplicatedAccountErrorDescription] ! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LMR 5/22/2023 00:04:04'!
assertThatPortfolio: aPortfolio hasRegistered: aDeposit and: anotherDeposit

	self assert:(aPortfolio hasRegistered: aDeposit).
	self assert:(aPortfolio hasRegistered: anotherDeposit)! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LMR 5/22/2023 00:06:27'!
assertThatPortfolio: aPortfolio hasTransaction: aTransaction and: anotherTransaction

	| portfolioTransactions |
	portfolioTransactions := aPortfolio transactions.
	self assert:(portfolioTransactions includes: aTransaction).
	self assert:(portfolioTransactions includes: anotherTransaction)! !


!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:01:19'!
test01EmptyPortfolioHasBalance0

	self assert: 0 equals: firstNewPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:01:16'!
test02PortfolioWithOneAccountHasBalanceEqualsToThatAccount

	Deposit register: 100 on: firstAccount .
	
	firstNewPortfolio add: firstAccount .

	self assert: 100 equals: firstNewPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:01:11'!
test03PortfolioWithMultipleAccountsHasBalanceEqualsToThose

	Deposit register: 100 on: firstAccount .
	Deposit register: 100 on: secondAccount .
	
	firstNewPortfolio add: firstAccount .
	firstNewPortfolio add: secondAccount .

	self assert: 200 equals: firstNewPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:01:05'!
test04PortfolioWithMultipleAccountsAndPortfolioHasBalanceEqualsToThose

	Deposit register: 100 on: firstAccount .
	Deposit register: 100 on: secondAccount .
	
	secondNewPortfolio add: secondAccount.
	firstNewPortfolio add: firstAccount .
	firstNewPortfolio add: secondNewPortfolio .

	self assert: 200 equals: firstNewPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:00:49'!
test05EmptyPortfolioHasNoTransactionRegistered
	
	| deposit |
	deposit := Deposit register: 100 on: firstAccount.

	self deny: (firstNewPortfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:04:58'!
test06PortfolioWithMultipleTransactionsOnAccountHasThemRegistered
	
	|deposit deposit2|
	
	deposit := Deposit register: 100 on: firstAccount .
	deposit2 := Deposit register: 100 on: secondAccount .
	
	firstNewPortfolio add: firstAccount.
	firstNewPortfolio add: secondAccount.

	self assertThatPortfolio: firstNewPortfolio hasRegistered: deposit and: deposit2! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:05:18'!
test07PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemRegistered
	
	|deposit deposit2|
	
	deposit := Deposit register: 100 on: firstAccount.
	deposit2 := Deposit register: 100 on: secondAccount.
	
	secondNewPortfolio add: secondAccount.
	firstNewPortfolio add: firstAccount.
	firstNewPortfolio add: secondNewPortfolio.

	self assertThatPortfolio: firstNewPortfolio hasRegistered: deposit and: deposit2! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 23:59:27'!
test08EmptyPortfolioHasNoTransaction
	

	self assert: (firstNewPortfolio transactions) isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:07:03'!
test09PortfolioWithMultipleTransactionsOnAccountHasThemInTransactions
	
	|deposit deposit2 |
	deposit := Deposit register: 100 on: firstAccount.
	deposit2 := Deposit register: 100 on: secondAccount.
	
	firstNewPortfolio add: firstAccount .
	firstNewPortfolio add: secondAccount.

	self assertThatPortfolio: firstNewPortfolio hasTransaction: deposit and: deposit2! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:07:16'!
test10PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemInTransactions
	
	|deposit deposit2 |
	deposit := Deposit register: 100 on: firstAccount.
	deposit2 := Deposit register: 100 on: secondAccount.
	
	secondNewPortfolio add: secondAccount.
	firstNewPortfolio add: firstAccount.
	firstNewPortfolio add: secondNewPortfolio.

	self assertThatPortfolio: firstNewPortfolio hasTransaction: deposit and: deposit2! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 23:58:06'!
test11CantAddPortfolioToItself
	
	self assertThatPortfolio: firstNewPortfolio canNotAdd: firstNewPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 23:58:32'!
test12CantAddAnAccountToAPortfolioMoreThanOnce
	
	firstNewPortfolio add: secondNewPortfolio.

	self assertThatPortfolio: firstNewPortfolio canNotAdd: secondNewPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/22/2023 00:18:13'!
test13CantAddAnAccountToAPortfolioAlreadyContainedInSubAccounts
	
	secondNewPortfolio add: firstAccount.
	firstNewPortfolio add: secondNewPortfolio.

	self assertThatPortfolio: firstNewPortfolio canNotAdd: firstAccount.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 23:03:47'!
test14CantAddAPortfolioToAnotherThatSharesASubAccount

	firstNewPortfolio add: thirdNewPortfolio .
	secondNewPortfolio add: fourthNewPortfolio.
	thirdNewPortfolio add: firstAccount.
	fourthNewPortfolio add: firstAccount.
	
	self assertThatPortfolio: firstNewPortfolio canNotAdd: secondNewPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 23:42:16'!
test15CantAddAPortfolioToAnotherThatSharesSubAccountsWithParents

	firstNewPortfolio add: thirdNewPortfolio.
	firstNewPortfolio add: firstAccount.
	secondNewPortfolio add: thirdNewPortfolio.
	fourthNewPortfolio add: firstAccount.
	
	self assertThatPortfolio: thirdNewPortfolio canNotAdd: fourthNewPortfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 23:57:23'!
test16CantAddAPortfolioToAnotherThatSharesSubAccountsWithRecursiveParents

	firstNewPortfolio add: secondNewPortfolio.
	firstNewPortfolio add: firstAccount.
	secondNewPortfolio add: thirdNewPortfolio.
	fourthNewPortfolio add: firstAccount.
	
	self assertThatPortfolio: thirdNewPortfolio canNotAdd: fourthNewPortfolio! !


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
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'balance' stamp: 'AlYac 5/18/2023 00:34:03'!
balance
	
	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'LMR 5/21/2023 22:51:51'!
hasAccount: anAccount
	
	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'AlYac 5/18/2023 00:34:20'!
hasRegistered: aTransaction
	
	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'LMR 5/22/2023 15:59:49'!
addAllTransactionsTo: transactionsCollection
	
	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'AlYac 5/18/2023 00:34:43'!
transactions
	
	self subclassResponsibility ! !


!Account methodsFor: 'validations' stamp: 'LMR 5/21/2023 23:52:13'!
canBeAddedToPortfolioWithRecursiveParents: recursiveParents

	self subclassResponsibility! !


!Account methodsFor: 'parents' stamp: 'LMR 5/21/2023 23:30:17'!
addToParents: aNewParent

	parents add: aNewParent.! !

!Account methodsFor: 'parents' stamp: 'LMR 5/21/2023 23:48:58'!
recursiveParents

	parents isEmpty ifTrue: [^OrderedCollection with: self].
	^parents inject: OrderedCollection new into: [:recursiveParents :aParent | recursiveParents , aParent recursiveParents]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Ejercicio'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'errors' stamp: 'LMR 5/22/2023 00:14:47'!
duplicatedAccountErrorDescription

	^ 'This account is already registered!!'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'add' stamp: 'LMR 5/21/2023 23:31:06'!
add: anAccount 
	
	self canAdd: anAccount.
	
	accounts add: anAccount.
	anAccount addToParents: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'LMR 5/21/2023 23:29:22'!
initialize
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'LMR 5/22/2023 16:00:49'!
addAllTransactionsTo: transactionsCollection
	
	accounts do: [:subAccount | subAccount addAllTransactionsTo: transactionsCollection]! !

!Portfolio methodsFor: 'transactions' stamp: 'LMR 5/22/2023 16:03:26'!
transactions
	
	| transactionsCollection |
	transactionsCollection := OrderedCollection new.
	self addAllTransactionsTo: transactionsCollection.
	^transactionsCollection! !


!Portfolio methodsFor: 'balance' stamp: 'LMR 5/21/2023 22:37:55'!
balance
	
	^ accounts sum: [:anAccount| anAccount balance] ifEmpty: [0] ! !


!Portfolio methodsFor: 'validations' stamp: 'LMR 5/21/2023 23:49:50'!
canAdd: anAccount

	anAccount canBeAddedToPortfolioWithRecursiveParents: self recursiveParents! !

!Portfolio methodsFor: 'validations' stamp: 'LMR 5/21/2023 23:51:11'!
canBeAddedToPortfolioWithRecursiveParents: recursiveParents

	(recursiveParents anySatisfy: [:parent | parent hasAccount: self]) ifTrue: [self error: self class duplicatedAccountErrorDescription].
	accounts do: [:subAccount | subAccount canBeAddedToPortfolioWithRecursiveParents: recursiveParents]! !


!Portfolio methodsFor: 'testing' stamp: 'LMR 5/21/2023 22:50:00'!
hasAccount: anAccount 
	
	^self = anAccount or: [accounts anySatisfy: [:subAccount | subAccount hasAccount: anAccount]]! !

!Portfolio methodsFor: 'testing' stamp: 'LMR 5/21/2023 22:37:55'!
hasRegistered: aTransaction 
	
	^ accounts anySatisfy: [:anAccount|anAccount hasRegistered: aTransaction]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'sdaasd 5/15/2023 20:48:35'!
new
	
	^self basicNew initialize! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LMR 5/21/2023 23:29:29'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'LMR 5/22/2023 16:01:19'!
addAllTransactionsTo: transactionsCollection
	
	transactionsCollection addAll: transactions! !

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


!ReceptiveAccount methodsFor: 'validations' stamp: 'LMR 5/21/2023 23:51:41'!
canBeAddedToPortfolioWithRecursiveParents: recursiveParents

	(recursiveParents anySatisfy: [:parent | parent hasAccount: self]) ifTrue: [self error: self class duplicatedAccountErrorDescription]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LMR 5/21/2023 22:51:27'!
hasAccount: anAccount 
	
	^self = anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
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
	instanceVariableNames: ''
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
	instanceVariableNames: ''
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
