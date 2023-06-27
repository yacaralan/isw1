!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 20:49:37'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 20:47:56'!
test02Import

	self should: [CustomerImporter valueFrom: nil into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: CustomerImporter nilInputErrorDescription equals: anError messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 20:53:50'!
test03Import

	| inputStream |
	inputStream := ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs
C,Pepe,Sanchez,D,22333444
A,Maipu,888,Florida,1122,Buenos Aires'.
	self should: [CustomerImporter valueFrom: inputStream into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: CustomerImporter firstLineAddressErrorDescription equals: anError messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 21:01:52'!
test04Import

	| inputStream |
	inputStream := ReadStream on: 'C,Pepe,San,chez,D,22333444'.
	self should: [CustomerImporter valueFrom: inputStream into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: CustomerImporter InvalidAmountOfFieldsErrorDescription equals: anError messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 21:05:46'!
test05Import

	| inputStream |
	inputStream := ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Ma,rtin,3322,Olivos,1636,BsAs'.
	self should: [CustomerImporter valueFrom: inputStream into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: CustomerImporter InvalidAmountOfFieldsErrorDescription equals: anError messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 21:23:03'!
test06Import

	| inputStream |
	inputStream := ReadStream on: 'C,Pepe,,Sanchez,D,22333444'.
	self should: [CustomerImporter valueFrom: inputStream into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: CustomerImporter emptyFieldErrorDescription equals: anError messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 21:35:14'!
test07Import

	| inputStream |
	inputStream := ReadStream on: 'J,Pepe,Sanchez,D,22333444'.
	self should: [CustomerImporter valueFrom: inputStream into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: CustomerImporter invalidRecordErrorDescrition equals: anError messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 21:43:29'!
test08Import

	| inputStream |
	inputStream := ReadStream on: ''.
	CustomerImporter valueFrom: inputStream into: session.
	self assert: (session selectAllOfType: Customer) isEmpty.
	self assert: (session selectAllOfType: Address) isEmpty.! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 21:47:06'!
test09Import

	| inputStream |
	inputStream := ReadStream on: '
'.
	self should: [CustomerImporter valueFrom: inputStream into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: CustomerImporter emptyFieldErrorDescription equals: anError messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'LMR 6/26/2023 21:59:00'!
test10Import

	| inputStream |
	inputStream := ReadStream on: 'Carlos,Pepe,Sanchez,D,22333444'.
	self should: [CustomerImporter valueFrom: inputStream into: session] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: CustomerImporter invalidRecordErrorDescrition equals: anError messageText].! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
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

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'initialization' stamp: 'LMR 6/26/2023 19:46:37'!
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

!Address class methodsFor: 'instance creation' stamp: 'LMR 6/26/2023 19:45:50'!
fromData: addressData 
	
	^self new initializeFromData: addressData ! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'LMR 6/26/2023 19:35:03'!
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

!Customer class methodsFor: 'instance creation' stamp: 'LMR 6/26/2023 19:33:42'!
fromData: customerData 
	
	^self new initializeFromData: customerData ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer lineFields'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 21:56:31'!
assertThatRecordHasFieldAmountEqualTo: aFieldAmount

	^ lineFields size = aFieldAmount ifFalse: [self error: self class InvalidAmountOfFieldsErrorDescription]! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 21:50:17'!
extractFields

	lineFields := line findTokens: $,.
	self hasEmptyFields ifTrue: [self error: self class emptyFieldErrorDescription].! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 21:50:17'!
hasEmptyFields

	^ lineFields size - 1 ~= (line occurrencesOf: $,)! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 20:21:40'!
hasNextLine

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 21:56:31'!
importAddress

	self assertThatRecordHasFieldAmountEqualTo: 6.
	newCustomer ifNil: [self error: self class firstLineAddressErrorDescription].
	newCustomer addAddress: (Address fromData: lineFields).! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 21:56:51'!
importCustomer

	self assertThatRecordHasFieldAmountEqualTo: 5.
	newCustomer := Customer fromData: lineFields.
	session persist: newCustomer.! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 21:38:10'!
importDataFromCurrentLine

	self extractFields.
	self isCustomerRecord ifTrue: [ self importCustomer. ^self ].
	self isAddressRecord ifTrue: [ self importAddress. ^self].
	self error: self class invalidRecordErrorDescrition.! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 20:14:51'!
isAddressRecord

	^lineFields first = 'A'! !

!CustomerImporter methodsFor: 'aux' stamp: 'LMR 6/26/2023 20:14:04'!
isCustomerRecord

	^lineFields first = 'C'! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'LMR 6/26/2023 20:21:27'!
value

	[ self hasNextLine ] whileTrue: [ self importDataFromCurrentLine ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LMR 6/26/2023 20:46:22'!
from: aReadStream into: aSession
	
	aReadStream ifNil: [self error: self nilInputErrorDescription].
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/26/2023 21:02:38'!
InvalidAmountOfFieldsErrorDescription

	^'Invalid amount of fields'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/26/2023 21:23:45'!
emptyFieldErrorDescription

	^'Empty field'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/26/2023 20:54:25'!
firstLineAddressErrorDescription

	^'First line can not be an address'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/26/2023 21:37:08'!
invalidRecordErrorDescrition

	^'Invalid record'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'LMR 6/26/2023 20:45:01'!
nilInputErrorDescription

	^'Input stream is nil'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
