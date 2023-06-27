!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 18:58:38'!
test01ValidImport

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:12:47'!
test02CanNotImportNilInput

	self assertThatImportingFrom: nil raisesErrorWithDescription: CustomerImporter nilInputErrorDescription.
	self assertThatSessionIsEmpty.! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:12:47'!
test03CanNotImportAddressBeforeCustomer

	| inputStream |
	inputStream := ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs
C,Pepe,Sanchez,D,22333444
A,Maipu,888,Florida,1122,Buenos Aires'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter firstLineAddressErrorDescription.
	self assertThatSessionIsEmpty! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:12:47'!
test04CanNotImportCustomerWithExtraFields

	| inputStream |
	inputStream := ReadStream on: 'C,Juan,Perez,C,23-25666777-9
C,Pepe,San,chez,D,22333444'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter InvalidAmountOfFieldsErrorDescription.
	self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:12:47'!
test05CanNotImportAddressWithExtraFields

	| inputStream pepe |
	inputStream := ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Ma,rtin,3322,Olivos,1636,BsAs'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter InvalidAmountOfFieldsErrorDescription.
	pepe := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertThatCustomer: pepe hasNoAddressesAtStreetNamed: 'San Ma'.! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:12:47'!
test06CanNotImportLineWithEmptyFields

	| inputStream |
	inputStream := ReadStream on: 'C,Pepe,,Sanchez,D,22333444'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter emptyFieldErrorDescription.
	self assertThatSessionIsEmpty! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:14:38'!
test07CanNotImportRecordWithInvalidType

	| inputStream |
	inputStream := ReadStream on: 'J,Pepe,Sanchez,D,22333444'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter invalidRecordErrorDescrition.
	self assertThatSessionIsEmpty.
	
	inputStream := ReadStream on: 'Carlos,Pepe,Sanchez,D,22333444'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter invalidRecordErrorDescrition.
	self assertThatSessionIsEmpty! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 19:59:39'!
test08ImportingEmptyStreamResultsInEmptySession

	| inputStream |
	inputStream := ReadStream on: ''.
	CustomerImporter valueFrom: inputStream into: session.
	self assertThatSessionIsEmpty.! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:12:47'!
test09CanNotImportEmptyLine

	| inputStream |
	inputStream := ReadStream on: '
'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter emptyFieldErrorDescription.
	self assertThatSessionIsEmpty.! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:14:51'!
test10CanNotImportCustomerWithMissingFields

	| inputStream |
	inputStream := ReadStream on: 'C,Juan,Perez,C,23-25666777-9
C,Pepe,Sanchez,D'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter InvalidAmountOfFieldsErrorDescription.
	self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/27/2023 20:14:56'!
test11CanNotImportAddressWithMissingFields

	| inputStream pepe |
	inputStream := ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'.
	self assertThatImportingFrom: inputStream raisesErrorWithDescription: CustomerImporter InvalidAmountOfFieldsErrorDescription.
	pepe := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertThatCustomer: pepe hasNoAddressesAtStreetNamed: 'San Ma'! !


!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 18:47:42'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 18:47:42'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 18:47:42'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 18:47:42'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 18:47:41'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 20:15:33'!
assertThatCustomer: aCustomer hasNoAddressesAtStreetNamed: streetName 

	|bool|
	bool := false.
	aCustomer addressAt: streetName ifNone: [bool := true].
	self assert: bool! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 20:12:47'!
assertThatImportingFrom: inputStream raisesErrorWithDescription: expectedErrorDesciption 

	^ self should: [CustomerImporter valueFrom: inputStream into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: expectedErrorDesciption equals: anError messageText.]! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 20:12:36'!
assertThatSessionIsEmpty

	self assertThatThereAreNoCustomersOnSession.
	self assertThatThereAreNoAddressesOnSession! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 19:36:25'!
assertThatThereAreNoAddressesOnSession

	^ self assert: (session selectAllOfType: Address) isEmpty! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/27/2023 18:57:24'!
assertThatThereAreNoCustomersOnSession

	^ self assert: (session selectAllOfType: Customer) isEmpty! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'LMR 6/27/2023 18:47:41'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'LMR 6/27/2023 18:47:42'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'LMR 6/27/2023 19:03:30'!
customerWithIdentificationType: anIdType number: anIdNumber

	| selection |
	selection := session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer.
	^(selection) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'LMR 6/27/2023 18:47:43'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'LMR 6/27/2023 18:47:34'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'LMR 6/27/2023 18:47:35'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'LMR 6/27/2023 18:47:36'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'LMR 6/27/2023 18:47:35'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'LMR 6/27/2023 18:47:35'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'LMR 6/27/2023 18:47:34'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'LMR 6/27/2023 18:47:35'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'LMR 6/27/2023 18:47:35'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'LMR 6/27/2023 18:47:35'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'LMR 6/27/2023 18:47:35'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'LMR 6/27/2023 18:47:35'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'initialization' stamp: 'LMR 6/27/2023 18:47:36'!
initializeFromData: addressData 
	
	streetName := addressData second.
	streetNumber := addressData third asNumber .
	town := addressData fourth.
	zipCode := addressData fifth asNumber .
	province := addressData sixth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'LMR 6/27/2023 18:47:36'!
fromData: addressData 
	
	^self new initializeFromData: addressData ! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'LMR 6/27/2023 18:47:36'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'LMR 6/27/2023 18:47:37'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'LMR 6/27/2023 18:47:36'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'LMR 6/27/2023 18:47:37'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'LMR 6/27/2023 18:47:36'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'LMR 6/27/2023 18:47:36'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'LMR 6/27/2023 18:47:36'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'LMR 6/27/2023 18:47:37'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'LMR 6/27/2023 18:47:36'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'LMR 6/27/2023 18:47:36'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'LMR 6/27/2023 18:47:36'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'LMR 6/27/2023 18:47:37'!
initializeFromData: customerData 
	
	super initialize.
	firstName := customerData second.
	lastName := customerData third.
	identificationType := customerData fourth.
	identificationNumber := customerData fifth.
	addresses := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'LMR 6/27/2023 18:47:37'!
fromData: customerData 
	
	^self new initializeFromData: customerData ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer lineFields'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'LMR 6/27/2023 18:48:17'!
initializeFrom: aReadStream into: aSession
	
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:39'!
assertThatRecordHasFieldAmountEqualTo: aFieldAmount

	^ lineFields size = aFieldAmount ifFalse: [self error: self class InvalidAmountOfFieldsErrorDescription]! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:38'!
extractFields

	lineFields := line findTokens: $,.
	self hasEmptyFields ifTrue: [self error: self class emptyFieldErrorDescription].! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:38'!
hasEmptyFields

	^ lineFields size - 1 ~= (line occurrencesOf: $,)! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:37'!
hasNextLine

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:39'!
importAddress

	self assertThatRecordHasFieldAmountEqualTo: 6.
	newCustomer ifNil: [self error: self class firstLineAddressErrorDescription].
	newCustomer addAddress: (Address fromData: lineFields).! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:39'!
importCustomer

	self assertThatRecordHasFieldAmountEqualTo: 5.
	newCustomer := Customer fromData: lineFields.
	session persist: newCustomer.! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:38'!
importDataFromCurrentLine

	self extractFields.
	self isCustomerRecord ifTrue: [ self importCustomer. ^self ].
	self isAddressRecord ifTrue: [ self importAddress. ^self].
	self error: self class invalidRecordErrorDescrition.! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:38'!
isAddressRecord

	^lineFields first = 'A'! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/27/2023 18:47:37'!
isCustomerRecord

	^lineFields first = 'C'! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'LMR 6/27/2023 18:47:38'!
value

	[ self hasNextLine ] whileTrue: [ self importDataFromCurrentLine ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LMR 6/27/2023 18:47:39'!
from: aReadStream into: aSession
	
	aReadStream ifNil: [self error: self nilInputErrorDescription].
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'LMR 6/27/2023 18:47:39'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/27/2023 18:47:40'!
InvalidAmountOfFieldsErrorDescription

	^'Invalid amount of fields'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/27/2023 18:47:39'!
emptyFieldErrorDescription

	^'Empty field'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/27/2023 18:47:39'!
firstLineAddressErrorDescription

	^'First line can not be an address'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/27/2023 18:47:39'!
invalidRecordErrorDescrition

	^'Invalid record'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/27/2023 18:47:39'!
nilInputErrorDescription

	^'Input stream is nil'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'LMR 6/27/2023 18:47:40'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'LMR 6/27/2023 18:47:41'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'LMR 6/27/2023 18:47:40'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'LMR 6/27/2023 18:47:40'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'LMR 6/27/2023 18:47:41'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'LMR 6/27/2023 18:47:40'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'LMR 6/27/2023 18:47:41'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'LMR 6/27/2023 18:47:40'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'LMR 6/27/2023 18:47:40'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'LMR 6/27/2023 18:47:40'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'LMR 6/27/2023 18:47:41'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'LMR 6/27/2023 18:47:40'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'LMR 6/27/2023 18:47:41'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
