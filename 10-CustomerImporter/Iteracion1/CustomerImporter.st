!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'testing' stamp: 'LMR 6/25/2023 18:02:56'!
test01Import

	| pepe juan inputStream |
	"inputStream := UniFileStream new open: 'input.txt' forWrite: false."
	inputStream := ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.
	(CustomerImporter importingCustomersFromStream: (inputStream) toSession: session) import.
	
	self assert: 2 equals: (session selectAllOfType: Customer) size.
	
	pepe := self getCustomerWithIdType: 'D' idNumber: '22333444' andAssertThatCustomerHasName: 'Pepe' lastName: 'Sanchez' amountOfAddresses: 2.
	self assertThatCustomer: pepe hasAnAddressOnStreetNamed: 'San Martin' withStreetNumber: 3322 onTown: 'Olivos' withZipCode: 1636 inProvince: 'BsAs'.
	self assertThatCustomer: pepe hasAnAddressOnStreetNamed: 'Maipu' withStreetNumber: 888 onTown: 'Florida' withZipCode: 1122 inProvince: 'Buenos Aires'.
	
	juan := self getCustomerWithIdType: 'C' idNumber: '23-25666777-9' andAssertThatCustomerHasName: 'Juan' lastName: 'Perez' amountOfAddresses: 1.
	self assertThatCustomer: juan hasAnAddressOnStreetNamed: 'Alem' withStreetNumber: 1122 onTown: 'CABA' withZipCode: 1001 inProvince: 'CABA'.! !


!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/25/2023 18:02:40'!
assertThatCustomer: aCustomer hasAnAddressOnStreetNamed: aStreetName withStreetNumber: aStreetNumber onTown: aTown withZipCode: aZipCode inProvince: aProvince     

	| anAddress |
	anAddress := aCustomer getAddressOnStreetNamed: aStreetName.
	self assert: aStreetNumber equals: anAddress streetNumber.
	self assert: aTown equals: anAddress town.
	self assert: aZipCode equals: anAddress zipCode.
	self assert: aProvince equals: anAddress province! !

!ImportTest methodsFor: 'assertions' stamp: 'LMR 6/25/2023 16:34:49'!
getCustomerWithIdType: idType idNumber: idNumber andAssertThatCustomerHasName: aCustomerName lastName: aCustomerLastName amountOfAddresses: amountOfAddresses    

	| customer |
	customer := (session select: [:aCustomer | aCustomer identificationType = idType and: [aCustomer identificationNumber = idNumber]] ofType: Customer) atRandom.
	self assert: aCustomerName equals: (customer firstName).
	self assert: aCustomerLastName equals: (customer lastName).
	self assert: amountOfAddresses equals: (customer amountOfAddresses).
	^customer! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'LMR 6/25/2023 16:04:05'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'LMR 6/25/2023 16:04:05'!
tearDown

	session commit.
	session close! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'LMR 6/25/2023 16:04:03'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'LMR 6/25/2023 16:04:02'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'LMR 6/25/2023 16:04:03'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'LMR 6/25/2023 16:04:03'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'LMR 6/25/2023 16:04:03'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'LMR 6/25/2023 16:04:03'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'LMR 6/25/2023 16:04:03'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'LMR 6/25/2023 16:04:03'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'LMR 6/25/2023 16:04:03'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'LMR 6/25/2023 16:04:03'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'LMR 6/25/2023 16:04:04'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'LMR 6/25/2023 16:04:03'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'LMR 6/25/2023 16:04:04'!
amountOfAddresses

	^ addresses size! !

!Customer methodsFor: 'addresses' stamp: 'LMR 6/25/2023 18:02:19'!
getAddressOnStreetNamed: aStreetName

	^ addresses detect: [:anAddress | anAddress streetName = aStreetName].! !


!Customer methodsFor: 'name' stamp: 'LMR 6/25/2023 16:04:04'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'LMR 6/25/2023 16:04:04'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'LMR 6/25/2023 16:04:04'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'LMR 6/25/2023 16:04:04'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'LMR 6/25/2023 16:04:04'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'LMR 6/25/2023 16:04:04'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'LMR 6/25/2023 16:04:04'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'LMR 6/25/2023 16:04:04'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'LMR 6/25/2023 16:04:03'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'inputStream session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'LMR 6/25/2023 17:24:40'!
initializeImportingCustomersFromStream: anInputStream toSession: aSession
	
	inputStream := anInputStream.
	session := aSession.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'LMR 6/25/2023 17:24:20'!
import

	"
	self importCustomers
	"
	| newCustomer line |

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].

	inputStream close.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LMR 6/25/2023 17:24:20'!
importingCustomersFromStream: anInputStream toSession: aSession
	^self new initializeImportingCustomersFromStream: anInputStream toSession: aSession! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'LMR 6/25/2023 16:04:04'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'LMR 6/25/2023 16:04:04'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'LMR 6/25/2023 16:04:04'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'LMR 6/25/2023 16:04:04'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'LMR 6/25/2023 16:04:04'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'LMR 6/25/2023 16:04:04'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'LMR 6/25/2023 16:04:04'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'LMR 6/25/2023 16:04:04'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'LMR 6/25/2023 16:04:04'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'LMR 6/25/2023 16:04:04'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'LMR 6/25/2023 16:04:04'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'LMR 6/25/2023 16:04:04'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'LMR 6/25/2023 16:04:05'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
