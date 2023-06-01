!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:34:59'!
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:00'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:00'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:00'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:00'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:00'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:00'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:00'!
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

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:01'!
test01AccountSummaryOfANewAccountIsEmpty

	self assert: (AccountSummary of: ReceptiveAccount new) report equals: (OrderedCollection with: 'Balance = 0')! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:01'!
test02AccountWithOneDepositHasItInItsAccountSummary

	| anAccount expectedSummary |
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	expectedSummary := OrderedCollection with: 'Depósito por 100.' with:'Balance = 100'.

	self assert: (AccountSummary of: anAccount) report equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:01'!
test03AccountWithOneWithdrawHasItInItsAccountSummary

	| anAccount expectedSummary |
	anAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anAccount.
	expectedSummary := OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100'.

	self assert: (AccountSummary of: anAccount) report equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:00'!
test04AccountWithOneTransferDepositHasItInItsAccountSummary

	| expectedSummary transfereeAccount transfererAccount |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	Transfer register: 100 from: transfererAccount to: transfereeAccount.
	expectedSummary := OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100'.

	self assert: (AccountSummary of: transfereeAccount ) report equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:01'!
test05AccountWithOneTransferWithdrawHasItInItsAccountSummary

	| expectedSummary transfereeAccount transfererAccount |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	Transfer register: 100 from: transfererAccount to: transfereeAccount.
	expectedSummary := OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100'.

	self assert: (AccountSummary of: transfererAccount ) report equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:00'!
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

	self assert: (AccountSummary of: accountOne) report equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:00'!
test07PortfolioWithMultipleTransactionsHasThemInItsAccountSummary

	| expectedSummary accountTwo accountOne aPorfolio |
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	Deposit register: 100 on: accountOne.
	Withdraw register: 50 on: accountOne.
	Deposit register: 70 on: accountTwo.
	Withdraw register: 10 on: accountTwo.
	
	aPorfolio := Portfolio new.
	aPorfolio add: accountOne.
	aPorfolio add: accountTwo.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: 'Depósito por 100.'.
	expectedSummary add: 'Extracción por 50.'.
	expectedSummary add: 'Depósito por 70.'.
	expectedSummary add: 'Extracción por 10.'.
	expectedSummary add: 'Balance = 110'.

	self assert: (AccountSummary of: aPorfolio) report equals: expectedSummary ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:00'!
test08NetTransferOfANewAccountIs0

	self assert: (NetTransfer of: ReceptiveAccount new) report equals: 0 ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:00'!
test09AnAccountWithATransferHasItInItsNetTransfer

	| accountOne accountTwo |
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	
	Transfer register: 100 from: accountOne to: accountTwo . 

	self assert: (NetTransfer of: accountOne) report equals: -100 ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:00'!
test10AnAccountWithMultipleTransactionsHasACorrectNetTransfer

	| accountOne accountTwo |
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	
	Transfer register: 100 from: accountOne to: accountTwo. 
	Transfer register: 250 from: accountTwo to: accountOne.
	Deposit register: 100 on: accountOne.
	Transfer register: 30 from: accountOne to: accountTwo.
	Transfer register: 15 from: accountTwo to: accountOne .

	self assert: (NetTransfer of: accountOne) report equals: 135 ! !

!ReportsTest methodsFor: 'test' stamp: 'LMR 5/31/2023 23:35:01'!
test11APortfolioWithMultipleTransactionsHasACorrectNetTransfer

	| accountOne accountTwo accountFour accountThree aPortfolio |
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	accountThree := ReceptiveAccount new.
	accountFour := ReceptiveAccount new.
	aPortfolio := Portfolio new.
	aPortfolio add: accountOne.
	aPortfolio add: accountThree.
	
	Transfer register: 100 from: accountOne to: accountTwo. 
	Deposit register: 100 on: accountOne.
	Transfer register: 250 from: accountTwo to: accountOne.
	
	Transfer register: 30 from: accountThree to: accountFour.
	Deposit register: 100 on: accountThree.
	Transfer register: 15 from: accountFour to: accountThree.
	

	self assert: (NetTransfer of: aPortfolio) report equals: 135 ! !


!classDefinition: #TransferTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:01'!
test01TransferBetweenTwoAccountsAffectsTheirBalance

	| transfereeAccount transfererAccount |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	Transfer register: 100 from: transfererAccount to: transfereeAccount.
	
	self assert: transfererAccount balance equals: -100.
	self assert: transfereeAccount balance equals: 100! !

!TransferTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:01'!
test02TransferBetweenTwoAccountsKnowItsTransactionsAndIsRegisteredInBoth

	| transfereeAccount transfererAccount aTransfer |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	aTransfer := Transfer register: 100 from: transfererAccount to: transfereeAccount.
	
	self assert: (transfererAccount hasRegistered: aTransfer withdraw).
	self assert: (transfereeAccount hasRegistered: aTransfer deposit).! !

!TransferTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:01'!
test03DepositOfATransferKnowsItsTransfer

	| transfereeAccount transfererAccount aTransfer |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	aTransfer := Transfer register: 100 from: transfererAccount to: transfereeAccount.

	self assert: aTransfer deposit transfer equals: aTransfer .! !

!TransferTest methodsFor: 'tests' stamp: 'LMR 5/31/2023 23:35:01'!
test04WithdrawOfATransferKnowsItsTransfer

	| transfereeAccount transfererAccount aTransfer |
	transfererAccount := ReceptiveAccount new.
	transfereeAccount := ReceptiveAccount new.
	aTransfer := Transfer register: 100 from: transfererAccount to: transfereeAccount.

	self assert: aTransfer withdraw transfer equals: aTransfer .! !


!classDefinition: #TreeReportsTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TreeReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TreeReportsTest methodsFor: 'tests' stamp: 'LMR 6/1/2023 00:44:40'!
test01NewPortfolioOnlyHasItsNameOnItsReport

	| aPortfolio expectedReport |
	aPortfolio := Portfolio named: 'Portfolio de la familia'.

	expectedReport := OrderedCollection with: 'Portfolio de la familia'.

	self assert: (PortfolioStructure of: aPortfolio) report equals: expectedReport. ! !

!TreeReportsTest methodsFor: 'tests' stamp: 'LMR 6/1/2023 00:44:40'!
test02PortfolioWithOneAccountHasBothNamesOnItsReport

	| aPortfolio myAccount expectedReport |
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	aPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount.

	expectedReport := OrderedCollection with: 'Portfolio de la familia' with: '   Cuenta Mia'.

	self assert: (PortfolioStructure of: aPortfolio) report equals: expectedReport. ! !

!TreeReportsTest methodsFor: 'tests' stamp: 'LMR 6/1/2023 00:44:40'!
test03PortfolioWithOnePortfolioHasBothNamesOnItsReport

	| familyPortfolio expectedReport childrenPortfolio |
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: childrenPortfolio.

	expectedReport := OrderedCollection new.
	expectedReport add: 'Portfolio de la familia'.
	expectedReport add: '   Portfolio de hijos'.

	self assert: (PortfolioStructure of: familyPortfolio) report equals: expectedReport. ! !

!TreeReportsTest methodsFor: 'tests' stamp: 'LMR 6/1/2023 00:44:40'!
test04PortfolioWithManyAccountHasAllNamesOnItsReport

	| aPortfolio myAccount expectedReport johnsAccount |
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	aPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: johnsAccount.

	expectedReport := OrderedCollection with: 'Portfolio de la familia' with: '   Cuenta Mia' with: '   Cuenta de Juan'.

	self assert: (PortfolioStructure of: aPortfolio) report equals: expectedReport. ! !

!TreeReportsTest methodsFor: 'tests' stamp: 'LMR 6/1/2023 00:44:40'!
test05PortfolioWithManyAccountAndPortfoliosHasAllNamesOnItsReportCorrectlyIndented

	| familyPortfolio myAccount expectedReport angiesAccount childrenPortfolio johnsAccount |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.

	expectedReport := OrderedCollection new.
	expectedReport add: 'Portfolio de la familia'.
	expectedReport add: '   Cuenta Mia'.
	expectedReport add: '   Portfolio de hijos'.
	expectedReport add: '      Cuenta de Juan'.
	expectedReport add: '      Cuenta de Angeles'.

	self assert: (PortfolioStructure of: familyPortfolio) report equals: expectedReport. ! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'LMR 5/31/2023 23:34:57'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'LMR 5/31/2023 23:34:57'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'LMR 5/31/2023 23:34:57'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'LMR 5/31/2023 23:34:57'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'LMR 5/31/2023 23:34:57'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LMR 5/31/2023 23:34:57'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'LMR 5/31/2023 23:34:56'!
fillReport: aReport

	self subclassResponsibility! !

!Account methodsFor: 'reports' stamp: 'LMR 6/1/2023 01:03:27'!
fillTreeReport: aTreeReport

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accounts management' stamp: 'LMR 5/31/2023 23:34:58'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'LMR 5/31/2023 23:34:58'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'LMR 5/31/2023 23:34:58'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'LMR 5/31/2023 23:34:58'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'LMR 5/31/2023 23:34:58'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:34:58'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'LMR 6/1/2023 00:16:13'!
initializeNamed: aName 
	
	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'LMR 6/1/2023 00:16:19'!
initializeNamed: aName with: anAccount

	name := aName.
	accounts := OrderedCollection with: anAccount.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'LMR 6/1/2023 00:38:23'!
initializeNamed: aName with: anAccount with: anotherAccount 
	
	name := aName.
	accounts := OrderedCollection with: anAccount with: anotherAccount.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'LMR 5/31/2023 23:34:58'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'LMR 5/31/2023 23:34:58'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'LMR 5/31/2023 23:34:58'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'LMR 5/31/2023 23:34:58'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'LMR 5/31/2023 23:34:58'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'LMR 5/31/2023 23:34:58'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'LMR 5/31/2023 23:34:58'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'LMR 5/31/2023 23:34:58'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'LMR 5/31/2023 23:34:58'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'LMR 5/31/2023 23:34:58'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'LMR 5/31/2023 23:34:58'!
fillReport: aReport 
	
	accounts do: [:anAccount| anAccount fillReport: aReport].! !

!Portfolio methodsFor: 'reports' stamp: 'LMR 6/1/2023 00:58:10'!
fillTreeReport: aTreeReport 
	
	aTreeReport addNameToReport: name.
	aTreeReport incrementIndentation.
	accounts do: [:account | account fillTreeReport: aTreeReport.].
	aTreeReport decrementIndentation.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:34:58'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:45:03'!
named: aName

	^self new initializeNamed: aName.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:55:48'!
named: aName with: anAccount 
	
	^self new initializeNamed: aName with: anAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'LMR 6/1/2023 00:37:29'!
named: aName with: anAccount with: anotherAccount 
	
	^self new initializeNamed: aName with: anAccount with: anotherAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:34:58'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:34:58'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error handling' stamp: 'LMR 6/1/2023 00:36:45'!
error: aRenameMe1 
	self shouldBeImplemented.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:34:59'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:55:21'!
initializeNamed: aName 

	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'LMR 5/31/2023 23:34:59'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'LMR 5/31/2023 23:35:00'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'LMR 5/31/2023 23:34:59'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'LMR 5/31/2023 23:34:59'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LMR 5/31/2023 23:34:59'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'LMR 5/31/2023 23:34:59'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'LMR 5/31/2023 23:35:00'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'LMR 5/31/2023 23:34:59'!
fillReport: aReport

	transactions do: [:transaction| transaction fillReport: aReport].
! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'LMR 6/1/2023 01:03:17'!
fillTreeReport: aTreeReport 
	
	aTreeReport addNameToReport: name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:55:09'!
named: aName
	
	^self new initializeNamed: aName! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'LMR 5/31/2023 23:34:57'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'LMR 5/31/2023 23:34:57'!
fillReport: aReport

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'balance' stamp: 'LMR 5/31/2023 23:34:57'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:34:57'!
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

!Deposit methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:34:57'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'LMR 5/31/2023 23:34:57'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'LMR 5/31/2023 23:34:57'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'LMR 5/31/2023 23:34:57'!
fillReport: aReport

	aReport addToReportDepositOf: self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:34:57'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'myTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferDeposit methodsFor: 'transfer' stamp: 'LMR 5/31/2023 23:35:01'!
transfer

	^myTransfer ! !


!TransferDeposit methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:35:01'!
initializeOn: anAccount fromTransfer: aTransfer

	myTransfer := aTransfer.
	anAccount register: self
! !


!TransferDeposit methodsFor: 'reports' stamp: 'LMR 5/31/2023 23:35:01'!
fillReport: aReport

	aReport addToReportTransferDepositOf: self value! !


!TransferDeposit methodsFor: 'balance' stamp: 'LMR 5/31/2023 23:35:01'!
affectBalance: currentBalance 
	
	^currentBalance + self value! !


!TransferDeposit methodsFor: 'value' stamp: 'LMR 5/31/2023 23:35:01'!
value
	
	^myTransfer value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:35:01'!
registerOn: anAccount fromTransfer: aTransfer

	^ self new initializeOn: anAccount fromTransfer: aTransfer ! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'myTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:35:01'!
initializeOn: anAccount fromTransfer: aTransfer

	myTransfer := aTransfer.
	anAccount register: self
! !


!TransferWithdraw methodsFor: 'reports' stamp: 'LMR 5/31/2023 23:35:01'!
fillReport: aReport
	
	aReport addToReportTransferWithdrawOf: self value! !


!TransferWithdraw methodsFor: 'balance' stamp: 'LMR 5/31/2023 23:35:02'!
affectBalance: currentBalance 
	
	^currentBalance - self value! !


!TransferWithdraw methodsFor: 'transfer' stamp: 'LMR 5/31/2023 23:35:02'!
transfer

	^myTransfer ! !


!TransferWithdraw methodsFor: 'value' stamp: 'LMR 5/31/2023 23:35:01'!
value
	
	^myTransfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:35:02'!
registerOn: anAccount fromTransfer: aTransfer

	^ self new initializeOn: anAccount fromTransfer: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:35:02'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'LMR 5/31/2023 23:35:02'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'LMR 5/31/2023 23:35:02'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'LMR 5/31/2023 23:35:02'!
fillReport: aReport

	aReport addToReportWithdrawOf: self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:35:02'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Report methodsFor: 'report' stamp: 'LMR 5/31/2023 23:35:00'!
report

	self subclassResponsibility! !


!Report methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:35:00'!
initializeOf: anAccount 
	
	account := anAccount.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:35:00'!
of: anAccount 
	
	^self new initializeOf: anAccount ! !


!classDefinition: #TransactionsReport category: 'Portfolio-Ejercicio'!
Report subclass: #TransactionsReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransactionsReport methodsFor: 'add to report' stamp: 'LMR 6/1/2023 01:01:52'!
addToReportDepositOf: anAmount

	self subclassResponsibility! !

!TransactionsReport methodsFor: 'add to report' stamp: 'LMR 6/1/2023 01:02:13'!
addToReportTransferDepositOf: anAmount

	self subclassResponsibility! !

!TransactionsReport methodsFor: 'add to report' stamp: 'LMR 6/1/2023 01:02:24'!
addToReportTransferWithdrawOf: anAmount

	self subclassResponsibility! !

!TransactionsReport methodsFor: 'add to report' stamp: 'LMR 6/1/2023 01:02:29'!
addToReportWithdrawOf: anAmount

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio-Ejercicio'!
TransactionsReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummary methodsFor: 'report' stamp: 'LMR 5/31/2023 23:34:57'!
report
	
	report := OrderedCollection new.
	account fillReport: self.
	self addToReportBalanceOf: account balance.
	^report 
! !


!AccountSummary methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:57'!
addToReportBalanceOf: anAmount
	
	^report add: 'Balance = ', anAmount asString
! !

!AccountSummary methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:57'!
addToReportDepositOf: anAmount
	
	^report add: 'Depósito por ', anAmount asString , '.'
! !

!AccountSummary methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:57'!
addToReportTransferDepositOf: anAmount
	
	^report add: 'Entrada por transferencia de ', anAmount asString , '.'
! !

!AccountSummary methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:57'!
addToReportTransferWithdrawOf: anAmount
	
	^report add: 'Salida por transferencia de ', anAmount asString , '.'
! !

!AccountSummary methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:57'!
addToReportWithdrawOf: anAmount
	
	^report add: 'Extracción por ', anAmount asString , '.'
! !


!classDefinition: #NetTransfer category: 'Portfolio-Ejercicio'!
TransactionsReport subclass: #NetTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!NetTransfer methodsFor: 'report' stamp: 'LMR 5/31/2023 23:34:58'!
report

	report := 0.
	account fillReport: self.
	^report ! !


!NetTransfer methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:58'!
addToReportDepositOf: anAmount
! !

!NetTransfer methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:57'!
addToReportTransferDepositOf: anAmount
	
	report := report + anAmount ! !

!NetTransfer methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:57'!
addToReportTransferWithdrawOf: anAmount
	
	report := report - anAmount ! !

!NetTransfer methodsFor: 'add to report' stamp: 'LMR 5/31/2023 23:34:58'!
addToReportWithdrawOf: anAmount
 ! !


!classDefinition: #TreeReport category: 'Portfolio-Ejercicio'!
Report subclass: #TreeReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #PortfolioStructure category: 'Portfolio-Ejercicio'!
TreeReport subclass: #PortfolioStructure
	instanceVariableNames: 'indentationLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioStructure methodsFor: 'initialization' stamp: 'LMR 6/1/2023 01:00:15'!
initializeOf: aPortfolio 

	account := aPortfolio.! !


!PortfolioStructure methodsFor: 'report' stamp: 'LMR 6/1/2023 01:00:15'!
report
	
	report := OrderedCollection new.
	indentationLevel := 0.
	account fillTreeReport: self.
	^report! !


!PortfolioStructure methodsFor: 'add to report' stamp: 'LMR 6/1/2023 00:46:32'!
addNameToReport: aName

	| indentation |
	indentation := ''.
	indentationLevel timesRepeat: [indentation := indentation , '   '].
	report add: indentation , aName.! !


!PortfolioStructure methodsFor: 'indentation' stamp: 'LMR 6/1/2023 00:43:19'!
decrementIndentation

	indentationLevel := indentationLevel - 1.! !

!PortfolioStructure methodsFor: 'indentation' stamp: 'LMR 6/1/2023 00:28:42'!
incrementIndentation

	indentationLevel := indentationLevel + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStructure class' category: 'Portfolio-Ejercicio'!
PortfolioStructure class
	instanceVariableNames: ''!

!PortfolioStructure class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:46:09'!
of: aPortfolio 
	
	^self new initializeOf: aPortfolio ! !


!classDefinition: #Transfer category: 'Portfolio-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'deposit withdraw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'transfer ends' stamp: 'LMR 5/31/2023 23:35:01'!
deposit

	^deposit ! !

!Transfer methodsFor: 'transfer ends' stamp: 'LMR 5/31/2023 23:35:01'!
withdraw

	^withdraw ! !


!Transfer methodsFor: 'value' stamp: 'LMR 5/31/2023 23:35:01'!
value

	^value! !


!Transfer methodsFor: 'initialization' stamp: 'LMR 5/31/2023 23:35:01'!
register: anAmount from: aTransfererAccount to: aTransfereeAccount

	deposit := TransferDeposit registerOn: aTransfereeAccount fromTransfer: self.
	withdraw := TransferWithdraw registerOn: aTransfererAccount fromTransfer: self.
	value := anAmount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'LMR 5/31/2023 23:35:01'!
register: anAmount from: aTransfererAccount to: aTransfereeAccount 

	^self new register: anAmount from: aTransfererAccount to: aTransfereeAccount.
	! !
