!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'firstNewPortfolio firstAccount secondAccount secondNewPortfolio thirdNewPortfolio fourthNewPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'set up' stamp: 'LMR 5/21/2023 17:42:27'!
setUp

	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	
	firstNewPortfolio := Portfolio new.
	secondNewPortfolio := Portfolio new.
	thirdNewPortfolio := Portfolio new.
	fourthNewPortfolio := Portfolio new.
	
	! !


!PortfolioTest methodsFor: 'assertions' stamp: 'LMR 5/21/2023 17:59:22'!
assertThat: aPortfolio canNotAdd: anAccount
	
	self should: [aPortfolio add: anAccount] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: Account duplicatedAccountErrorDescription] ! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LMR 5/21/2023 17:46:22'!
assertThatPortfolio: aPortfolio hasRegistered: aDeposit and: anotherDeposit

	self assert:(aPortfolio hasRegistered: aDeposit).
	self assert:(aPortfolio hasRegistered: anotherDeposit)! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LMR 5/21/2023 17:49:58'!
assertThatPortfolio: aPortfolio hasTransaction: aTransaction and: anotherTransaction

	| portfolioTransactions |
	portfolioTransactions := aPortfolio transactions.
	self assert:(portfolioTransactions includes: aTransaction).
	self assert:(portfolioTransactions includes: anotherTransaction)! !


!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:27'!
test01EmptyPortfolioHasBalance0

	self assert: 0 equals: firstNewPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:27'!
test02PortfolioWithOneAccountHasBalanceEqualsToThatAccount

	Deposit register: 100 on: firstAccount .
	firstNewPortfolio add: firstAccount .
	self assert: 100 equals: firstNewPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test03PortfolioWithMultipleAccountsHasBalanceEqualsToThose

	Deposit register: 100 on: firstAccount .
	Deposit register: 100 on: secondAccount .
	
	firstNewPortfolio add: firstAccount .
	firstNewPortfolio add: secondAccount .

	self assert: 200 equals: firstNewPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test04PortfolioWithMultipleAccountsAndPortfolioHasBalanceEqualsToThose

	Deposit register: 100 on: firstAccount .
	Deposit register: 100 on: secondAccount .
	
	secondNewPortfolio add: secondAccount.
	firstNewPortfolio add: firstAccount .
	firstNewPortfolio add: secondNewPortfolio .

	self assert: 200 equals: firstNewPortfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test05EmptyPortfolioHasNoTransactionRegistered
	
	| deposit |
	deposit := Deposit register: 100 on: firstAccount.

	self deny: (firstNewPortfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:47:20'!
test06PortfolioWithMultipleTransactionsOnAccountHasThemRegistered
	
	|deposit deposit2|
	
	deposit := Deposit register: 100 on: firstAccount .
	deposit2 := Deposit register: 100 on: secondAccount .
	
	firstNewPortfolio add: firstAccount.
	firstNewPortfolio add: secondAccount.

	self assertThatPortfolio: firstNewPortfolio hasRegistered: deposit and: deposit2! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:47:32'!
test07PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemRegistered
	
	|deposit deposit2|
	
	deposit := Deposit register: 100 on: firstAccount.
	deposit2 := Deposit register: 100 on: secondAccount.
	
	secondNewPortfolio add: secondAccount.
	firstNewPortfolio add: firstAccount.
	firstNewPortfolio add: secondNewPortfolio.

	self assertThatPortfolio: firstNewPortfolio hasRegistered: deposit and: deposit2! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:27'!
test08EmptyPortfolioHasNoTransaction
	

	self assert: (firstNewPortfolio transactions) isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:50:33'!
test09PortfolioWithMultipleTransactionsOnAccountHasThemInTransactions
	
	|deposit deposit2|
	deposit := Deposit register: 100 on: firstAccount.
	deposit2 := Deposit register: 100 on: secondAccount.
	
	firstNewPortfolio add: firstAccount .
	firstNewPortfolio add: secondAccount.

	self assertThatPortfolio: firstNewPortfolio hasTransaction: deposit and: deposit2! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:52:09'!
test10PortfolioWithMultipleTransactionsOnAccountAndPortfoliosHasThemInTransactions
	
	|deposit deposit2|
	deposit := Deposit register: 100 on: firstAccount.
	deposit2 := Deposit register: 100 on: secondAccount.
	
	secondNewPortfolio add: secondAccount.
	firstNewPortfolio add: firstAccount.
	firstNewPortfolio add: secondNewPortfolio.

	self assertThatPortfolio: firstNewPortfolio hasTransaction: deposit and: deposit2! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 18:00:27'!
test11CantAddAPortfolioToItself
	
	self assertThat: firstNewPortfolio canNotAdd: firstNewPortfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 18:00:23'!
test12CantAddAnAccountToAPortfolioMoreThanOnce
	
	firstNewPortfolio add: secondNewPortfolio .

	self assertThat: firstNewPortfolio canNotAdd: secondNewPortfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 18:02:30'!
test13CantAddAnAccountToAPortfolioAlreadyContainedInSubAccounts

	secondNewPortfolio add: firstAccount.
	firstNewPortfolio add: secondNewPortfolio.
	
	self assertThat: firstNewPortfolio canNotAdd: firstAccount! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 18:02:26'!
test14CantAddAPortfolioToAnotherThatSharesASubAccount

	firstNewPortfolio add: thirdNewPortfolio .
	secondNewPortfolio add: fourthNewPortfolio.
	thirdNewPortfolio add: firstAccount.
	fourthNewPortfolio add: firstAccount.
	
	self assertThat: firstNewPortfolio canNotAdd: secondNewPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 18:02:22'!
test15CantAddAPortfolioToAnotherThatSharesSubAccountsWithParents

	firstNewPortfolio add: thirdNewPortfolio.
	firstNewPortfolio add: firstAccount.
	secondNewPortfolio add: thirdNewPortfolio.
	fourthNewPortfolio add: firstAccount.
	
	self assertThat: thirdNewPortfolio canNotAdd: fourthNewPortfolio! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:28'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/21/2023 17:42:29'!
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

!Account methodsFor: 'balance' stamp: 'LMR 5/21/2023 17:42:26'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'LMR 5/21/2023 17:42:26'!
hasAccount: anAccount

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'LMR 5/21/2023 17:42:26'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'LMR 5/21/2023 17:42:26'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'validations' stamp: 'LMR 5/21/2023 17:42:26'!
canAdd

	self subclassResponsibility ! !

!Account methodsFor: 'validations' stamp: 'LMR 5/21/2023 17:42:26'!
canAddAccountWithRecursiveParents: recursiveParentsOfAnAccount

	self subclassResponsibility ! !

!Account methodsFor: 'validations' stamp: 'LMR 5/21/2023 17:42:26'!
canBeAddedTo: aPortfolio

	self canBeAddedToPortfolioWithRecursiveParents: aPortfolio recursiveParents.! !


!Account methodsFor: 'parents' stamp: 'LMR 5/21/2023 17:42:26'!
addToParents: aNewParent

	parents add: aNewParent.! !

!Account methodsFor: 'parents' stamp: 'LMR 5/21/2023 17:42:26'!
recursiveParents

	parents isEmpty ifTrue: [^OrderedCollection with: self].
	^parents inject: OrderedCollection new into: [:recursiveParents :aParent | recursiveParents , aParent recursiveParents]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Ejercicio'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'errors' stamp: 'LMR 5/21/2023 18:10:33'!
duplicatedAccountErrorDescription
	
	^ 'This account is already registered!!'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'add' stamp: 'LMR 5/21/2023 18:16:08'!
add: anAccount 

	self canAdd: anAccount.
	
	accounts add: anAccount.
	anAccount addToParents: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'LMR 5/21/2023 18:16:08'!
initialize
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'LMR 5/21/2023 18:16:08'!
transactions
	
	^accounts inject: OrderedCollection new into: [:transactions :anAccount | transactions , anAccount transactions]! !


!Portfolio methodsFor: 'balance' stamp: 'LMR 5/21/2023 18:16:08'!
balance

	^ accounts sum: [:anAccount| anAccount balance] ifEmpty: [0] ! !


!Portfolio methodsFor: 'validations' stamp: 'LMR 5/21/2023 17:42:27'!
canAdd: anAccount

	anAccount canBeAddedTo: self.! !

!Portfolio methodsFor: 'validations' stamp: 'LMR 5/21/2023 18:16:08'!
canBeAddedToPortfolioWithRecursiveParents: recursiveParentsOfAPortfolio

	(recursiveParentsOfAPortfolio anySatisfy: [:aParent | aParent hasAccount: self]) ifTrue: [self error: self class duplicatedAccountErrorDescription].
	accounts do: [:anAccount | anAccount canBeAddedToPortfolioWithRecursiveParents: recursiveParentsOfAPortfolio]! !


!Portfolio methodsFor: 'testing' stamp: 'LMR 5/21/2023 18:16:08'!
hasAccount: anAccount
	
	^(self = anAccount) or: [accounts anySatisfy: [:oneOfMyAccounts | oneOfMyAccounts hasAccount: anAccount]]! !

!Portfolio methodsFor: 'testing' stamp: 'LMR 5/21/2023 18:16:08'!
hasRegistered: aTransaction
	
	^ accounts anySatisfy: [:anAccount|anAccount hasRegistered: aTransaction]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'LMR 5/21/2023 17:42:27'!
new
	
	^self basicNew initialize! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LMR 5/21/2023 17:42:28'!
initialize
	
	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'LMR 5/21/2023 17:42:28'!
register: aTransaction
	
	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'LMR 5/21/2023 17:42:28'!
transactions

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'LMR 5/21/2023 17:42:28'!
balance
	
	|balance|
	balance := 0.
	transactions do: [:aTransaction |balance := aTransaction effectOnBalance: balance].
	^balance! !


!ReceptiveAccount methodsFor: 'validations' stamp: 'LMR 5/21/2023 17:42:28'!
canBeAddedToPortfolioWithRecursiveParents: recursiveParentsOfAPortfolio

	(recursiveParentsOfAPortfolio anySatisfy: [:aParent | aParent hasAccount: self]) ifTrue: [self error: self class duplicatedAccountErrorDescription].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LMR 5/21/2023 17:42:28'!
hasAccount: anAccount
	
	^self = anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'LMR 5/21/2023 17:42:28'!
hasRegistered: aTransaction
	
	^ transactions includes: aTransaction! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'LMR 5/21/2023 17:42:26'!
effectOnBalance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'LMR 5/21/2023 17:42:26'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'LMR 5/21/2023 17:42:26'!
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

!Deposit methodsFor: 'initialization' stamp: 'LMR 5/21/2023 17:42:26'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'LMR 5/21/2023 17:42:26'!
effectOnBalance: aBalance
	
	^aBalance + self value.! !

!Deposit methodsFor: 'value' stamp: 'LMR 5/21/2023 17:42:26'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'LMR 5/21/2023 17:42:26'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'LMR 5/21/2023 17:42:29'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'LMR 5/21/2023 17:42:29'!
effectOnBalance: aBalance
	
	^aBalance + self value negated! !

!Withdraw methodsFor: 'value' stamp: 'LMR 5/21/2023 17:42:29'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'LMR 5/21/2023 17:42:29'!
for: aValue

	^ self new initializeFor: aValue ! !
