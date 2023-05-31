!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AlYac 5/30/2023 21:52:21'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AlYac 5/30/2023 21:52:46'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportsTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportsTest methodsFor: 'test' stamp: 'AlYac 5/30/2023 21:49:03'!
test01AccountSummaryOfANewAccountIsEmpty

	self assert: (AccountSummary of: ReceptiveAccount new) print equals: (OrderedCollection with: 'Balance = 0')! !

!ReportsTest methodsFor: 'test' stamp: 'AlYac 5/30/2023 21:48:13'!
test02AccountWithOneDepositHasItInItsAccountSummary

	| anAccount expectedSummary |
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	expectedSummary := OrderedCollection with: 'Depósito por 100.' with:'Balance = 100'.

	self assert: (AccountSummary of: anAccount) print equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'AlYac 5/30/2023 21:48:03'!
test03AccountWithOneWithdrawHasItInItsAccountSummary

	| anAccount expectedSummary |
	anAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anAccount.
	expectedSummary := OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100'.

	self assert: (AccountSummary of: anAccount) print equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'AlYac 5/30/2023 21:47:54'!
test04AccountWithOneTransferDepositHasItInItsAccountSummary

	| expectedSummary transfereeAccount transfererAccount |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	Transfer register: 100 from: transfererAccount to: transfereeAccount.
	expectedSummary := OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100'.

	self assert: (AccountSummary of: transfereeAccount ) print equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'AlYac 5/30/2023 21:47:33'!
test05AccountWithOneTransferWithdrawHasItInItsAccountSummary

	| expectedSummary transfereeAccount transfererAccount |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	Transfer register: 100 from: transfererAccount to: transfereeAccount.
	expectedSummary := OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100'.

	self assert: (AccountSummary of: transfererAccount ) print equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'AlYac 5/30/2023 21:46:42'!
test06AccountWithMultipleTransactionsHasThemInItsAccountSummary

	| expectedSummary accountTwo accountOne |
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	Deposit register: 100 on: accountOne.
	Withdraw register: 10 on: accountOne.
	Transfer register: 50 from: accountOne to: accountTwo.
	Transfer register: 30 from: accountTwo to: accountOne.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: 'Depósito por 100.'.
	expectedSummary add: 'Extracción por 10.'.
	expectedSummary add: 'Salida por transferencia de 50.'.
	expectedSummary add: 'Entrada por transferencia de 30.'.
	expectedSummary add: 'Balance = 70'.

	self assert: (AccountSummary of: accountOne) print equals: expectedSummary ! !


!classDefinition: #TransferTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'AYac 5/22/2023 21:40:34'!
test01TransferBetweenTwoAccountsAffectsTheirBalance

	| transfereeAccount transfererAccount |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	Transfer register: 100 from: transfererAccount to: transfereeAccount.
	
	self assert: transfererAccount balance equals: -100.
	self assert: transfereeAccount balance equals: 100! !

!TransferTest methodsFor: 'tests' stamp: 'AlYac 5/30/2023 17:23:40'!
test02TransferBetweenTwoAccountsKnowItsTransactionsAndIsRegisteredInBoth

	| transfereeAccount transfererAccount aTransfer |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	aTransfer := Transfer register: 100 from: transfererAccount to: transfereeAccount.
	
	self assert: (transfererAccount hasRegistered: aTransfer withdraw).
	self assert: (transfereeAccount hasRegistered: aTransfer deposit).! !

!TransferTest methodsFor: 'tests' stamp: 'AlYac 5/30/2023 17:26:43'!
test03DepositOfATransferKnowsItsTransfer

	| transfereeAccount transfererAccount aTransfer |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	aTransfer := Transfer register: 100 from: transfererAccount to: transfereeAccount.

	self assert: aTransfer deposit transfer equals: aTransfer .! !

!TransferTest methodsFor: 'tests' stamp: 'AlYac 5/30/2023 18:03:26'!
test04WithdrawOfATransferKnowsItsTransfer

	| transfereeAccount transfererAccount aTransfer |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	aTransfer := Transfer register: 100 from: transfererAccount to: transfereeAccount.

	self assert: aTransfer withdraw transfer equals: aTransfer .! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'AlYac 5/30/2023 20:07:39'!
accountSummary
	
	| summary |
	summary := OrderedCollection new.
	transactions do: [:transaction| transaction printOnSummary: summary].
	summary add: 'Balance = ', self balance asString.
	^summary 
! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'AlYac 5/30/2023 21:29:05'!
fillAccountSummary: aSummary

	transactions do: [:transaction| transaction printOnSummary: aSummary].
	aSummary printBalanceOf: self balance
! !


!classDefinition: #AccountSummary category: 'Portfolio-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummary methodsFor: 'initialization' stamp: 'AlYac 5/30/2023 21:32:15'!
initializeOf: anAccount

	account := anAccount.
	summary := OrderedCollection new! !


!AccountSummary methodsFor: 'print' stamp: 'AlYac 5/30/2023 21:44:48'!
print
	
	account fillAccountSummary: self.
	^summary 
! !

!AccountSummary methodsFor: 'print' stamp: 'AlYac 5/30/2023 21:36:52'!
printBalanceOf: anAmount
	
	^summary add: 'Balance = ', anAmount asString
! !

!AccountSummary methodsFor: 'print' stamp: 'AlYac 5/30/2023 21:35:21'!
printDepositOf: anAmount
	
	^summary add: 'Depósito por ', anAmount asString , '.'
! !

!AccountSummary methodsFor: 'print' stamp: 'AlYac 5/30/2023 21:35:46'!
printTransferDepositOf: anAmount
	
	^summary add: 'Entrada por transferencia de ', anAmount asString , '.'
! !

!AccountSummary methodsFor: 'print' stamp: 'AlYac 5/30/2023 21:35:58'!
printTransferWithdrawOf: anAmount
	
	^summary add: 'Salida por transferencia de ', anAmount asString , '.'
! !

!AccountSummary methodsFor: 'print' stamp: 'AlYac 5/30/2023 21:34:57'!
printWithdrawOf: anAmount
	
	^summary add: 'Extracción por ', anAmount asString , '.'
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'initialization' stamp: 'AlYac 5/30/2023 20:56:13'!
of: anAccount
	
	^self new initializeOf: anAccount ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'AlYac 5/30/2023 20:07:39'!
printOnSummary: anAccountSummary

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'AlYac 5/30/2023 21:40:01'!
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


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'AlYac 5/30/2023 21:25:45'!
printOnSummary: anAccountSummary

	anAccountSummary printDepositOf: self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'AlYac 5/30/2023 20:55:27'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'myTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferDeposit methodsFor: 'transfer' stamp: 'AlYac 5/30/2023 17:29:55'!
transfer

	^myTransfer ! !


!TransferDeposit methodsFor: 'initialization' stamp: 'AlYac 5/30/2023 17:58:10'!
initializeOn: anAccount fromTransfer: aTransfer

	myTransfer := aTransfer.
	anAccount register: self
! !


!TransferDeposit methodsFor: 'reports' stamp: 'AlYac 5/30/2023 21:27:46'!
printOnSummary: anAccountSummary

	anAccountSummary printTransferDepositOf: self value! !


!TransferDeposit methodsFor: 'balance' stamp: 'AlYac 5/30/2023 19:09:11'!
affectBalance: currentBalance 
	
	^currentBalance + self value! !


!TransferDeposit methodsFor: 'value' stamp: 'AlYac 5/30/2023 19:10:48'!
value
	
	^myTransfer value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'AlYac 5/30/2023 17:55:29'!
registerOn: anAccount fromTransfer: aTransfer

	^ self new initializeOn: anAccount fromTransfer: aTransfer ! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'myTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'AlYac 5/30/2023 18:05:02'!
initializeOn: anAccount fromTransfer: aTransfer

	myTransfer := aTransfer.
	anAccount register: self
! !


!TransferWithdraw methodsFor: 'reports' stamp: 'AlYac 5/30/2023 21:27:19'!
printOnSummary: anAccountSummary
	
	anAccountSummary printTransferWithdrawOf: self value! !


!TransferWithdraw methodsFor: 'balance' stamp: 'AlYac 5/30/2023 19:13:38'!
affectBalance: currentBalance 
	
	^currentBalance - self value! !


!TransferWithdraw methodsFor: 'transfer' stamp: 'AlYac 5/30/2023 18:06:04'!
transfer

	^myTransfer ! !


!TransferWithdraw methodsFor: 'value' stamp: 'AlYac 5/30/2023 19:13:57'!
value
	
	^myTransfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'AlYac 5/30/2023 18:04:47'!
registerOn: anAccount fromTransfer: aTransfer

	^ self new initializeOn: anAccount fromTransfer: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'AlYac 5/30/2023 21:26:36'!
printOnSummary: anAccountSummary

	anAccountSummary printWithdrawOf: self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'AlYac 5/30/2023 20:55:14'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'deposit withdraw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'transfer ends' stamp: 'AlYac 5/30/2023 17:58:59'!
deposit

	^deposit ! !

!Transfer methodsFor: 'transfer ends' stamp: 'AlYac 5/30/2023 18:02:37'!
withdraw

	^withdraw ! !


!Transfer methodsFor: 'value' stamp: 'AlYac 5/30/2023 18:01:27'!
value

	^value! !


!Transfer methodsFor: 'initialization' stamp: 'AlYac 5/30/2023 18:06:59'!
register: anAmount from: aTransfererAccount to: aTransfereeAccount

	deposit := TransferDeposit registerOn: aTransfereeAccount fromTransfer: self.
	withdraw := TransferWithdraw registerOn: aTransfererAccount fromTransfer: self.
	value := anAmount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AlYac 5/30/2023 17:42:58'!
register: anAmount from: aTransfererAccount to: aTransfereeAccount 

	^self new register: anAmount from: aTransfererAccount to: aTransfereeAccount.
	! !

