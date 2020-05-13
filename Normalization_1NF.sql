-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1		-- Get out of the master database
SET NOCOUNT ON	-- Report only errors

-- Problem 1

-- TFlights
--	intFlightID
--	strFlightNumber
--	strDescription		(e.g. CVG to ATL)
--	strPilotName
--	strPilotPhoneNumber
--	strCoPilotName
--	strCoPilotPhoneNumber
--	strBackupPilotName
--	strBackupPilotPhoneNumber
--	strAirplaneNumber
--	strAirplaneType
--	intAirplaneCapacity
--	strPassenger001Name
--	strPassenger001PhoneNumber
--	strPassenger001SeatNumber
--	.
--	.
--	.
--	strPassenger200Name
--	strPassenger200PhoneNumber
--	strPassenger200SeatNumber
--	strChiefFlightAttendantName
--	strChiefFlightAttendantPhoneNumber
--	strFlightAttendant01Name
--	strFlightAttendant01PhoneNumber
--	...
--	strFlightAttendant05Name
--	strFlightAttendant05PhoneNumber


-- --------------------------------------------------------------------------------
-- Step #1.1: Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TFlightFlightAttendants
DROP TABLE TFlightPassengers 
DROP TABLE TFlightPilots
DROP TABLE	TFlights

-- --------------------------------------------------------------------------------
-- Step #1.2: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TFlights
(
	 intFlightID						INTEGER					NOT NULL
	,strFlightNumber					VARCHAR(50)				NOT NULL
	,strDescription						VARCHAR(50)				NOT NULL
	,strAirplaneNumber					VARCHAR(50)				NOT NULL
	,strAirplaneType					VARCHAR(50)				NOT NULL
	,intAirplaneCapacity				INTEGER					NOT NULL
	CONSTRAINT TFlights_PK PRIMARY KEY (intFlightID) 
)
CREATE TABLE TFlightPilots
(
	 intFlightID						INTEGER					NOT NULL 
	,intPilotIndex						INTEGER					NOT NULL
	,strPilotRole						VARCHAR(50)				NOT NULL
	,strPilotFirstName					VARCHAR(50)				NOT NULL
	,strPilotLastName					VARCHAR(50)				NOT NULL 
	,strPilotPhoneNumber				VARCHAR(50)				NOT NULL
	CONSTRAINT TFlightPilots_PK PRIMARY KEY (intFlightID, intPilotIndex) 
)	
CREATE TABLE TFlightPassengers
(
	 intFlightID						INTEGER					NOT NULL
	,intPassengerIndex					INTEGER					NOT NULL
	,strPassengerFirstName				VARCHAR(50)				NOT NULL
	,strPassengerLastName				VARCHAR(50)				NOT NULL
	,strPassengerPhoneNumber			VARCHAR(50)				NOT NULL
	,strPassengerSeatNumber				VARCHAR(50)				NOT NULL 
	CONSTRAINT TFlightPassengers_PK PRIMARY KEY (intFlightID, intPassengerIndex) 
)
CREATE TABLE TFlightFlightAttendants
(
	 intFlightID						INTEGER					NOT NULL 
	,intFlightAttendantIndex			INTEGER					NOT NULL
	,strFlightAttendantRole				VARCHAR(50)				NOT NULL
	,strFlightAttendantFirstName		VARCHAR(50)				NOT NULL 
	,strFlightAttendantLastName			VARCHAR(50)				NOT NULL
	,strFlightAttendantPhoneNumber		VARCHAR(50)				NOT NULL 
	CONSTRAINT TFlightFlightAttendants_PK PRIMARY KEY (intFlightID,intFlightAttendantIndex) 
)	

-- --------------------------------------------------------------------------------
-- Step #1.3: Identify and Create Foreign Key
-- --------------------------------------------------------------------------------
--	#				Child						Parent						Column(s)
--	--				-----						------						-------
--	1				TFlightPilots				TFlights					intFlightID
--	2				TFlightPassengers			TFlights					intFlightID
--	3				TFlightFlightAttendants		TFlights					intFlightID

--	1
ALTER TABLE TFlightPilots ADD CONSTRAINT TFlightPilots_TFlights_FK 
	FOREIGN KEY (intFlightID) REFERENCES TFlights(intFlightID)

--	2
ALTER TABLE TFlightPassengers ADD CONSTRAINT TFlightPassengers_TFlights_FK 
	FOREIGN KEY (intFlightID) REFERENCES TFlights(intFlightID) 

--	3
ALTER TABLE TFlightFlightAttendants ADD CONSTRAINT TFlightFlightAttendants_TFlights_FK 
	FOREIGN KEY (intFlightID) REFERENCES TFlights(intFlightID) 

-- --------------------------------------------------------------------------------
-- Step #1.4: INSERT Statements
-- --------------------------------------------------------------------------------

INSERT INTO TFlights(intFlightID,strFlightNumber,strDescription,strAirplaneNumber,strAirplaneType,intAirplaneCapacity)
VALUES				 (1,'FNumber1','Description1','ANumber1','AType1',100)
					,(2,'FNumber2','Description2','ANumber2','AType2',200)
					,(3,'FNumber3','Description3','ANumber3','AType3',300)



INSERT INTO TFlightPilots(intFlightID,intPilotIndex,strPilotRole,strPilotFirstName,strPilotLastName,strPilotPhoneNumber)
VALUES				 (1,1,'Co','PFirstName11','PLastName11','PPhoneNumber11')
					,(1,2,'Back-Up','PFirstName12','PLastName12','PPhoneNUmber12')

					,(2,1,'Back-Up','PFirstName21','PlastName21','PPhoneNumber21')
					,(2,2,'Co','PFirstName22','PlastName22','PPhoneNumber22')

					,(3,1,'Co','PFirstName31','PLastName31','PPhoneNumber31')
					,(3,2,'Back-Up','PFirstName32','PLastName32','PPhoneNumber32')

INSERT INTO TFlightFlightAttendants(intFlightID,intFlightAttendantIndex,strFlightAttendantRole,strFlightAttendantFirstName,strFlightAttendantLastName,strFlightAttendantPhoneNumber)
VALUES				 (1,1,'Chief','AttendantFirstName11','AttendantLastName11','AttendantPhoneNumber11')
					,(1,2,'Role12','AttendantFirstName12','AttendantLastName12','AttendantPhoneNumber12')

					,(2,1,'Chief','AttendantFirstName21','AttendantLastName21','AttendantPhoneNumber21')
					,(2,2,'Role22','AttendantFirstName22','AttendantLastName22','AttendantPhoneNumber22')

					,(3,1,'Role31','AttendantFirstName31','AttendantLastName31','AttendantPhoneNumber31')
					,(3,2,'Chief','AttendantFirstName32','AttendantLastName32','AttendantPhoneNumber32')

INSERT INTO TFlightPassengers(intFlightID,intPassengerIndex,strPassengerFirstName,strPassengerLastName,strPassengerPhoneNumber,strPassengerSeatNumber)
VALUES				 (1,1,'PassengerFirstName11','PassengerLastName11','PassengerPhoneNumber11','PassengerSeatNumber11')
					,(1,2,'PassengerFirstName12','PassengerLastName12','PassengerPhoneNumber12','PassengerSeatNumber12')
					
					,(2,1,'PassengerFirstName21','PassengerLastName21','PassengerPhoneNumber21','PassengerSeatNumber21')
					,(2,2,'PassengerFirstName22','PassengerLastName22','PassengerPhoneNumber22','PassengerSeatNumber22')
					
					,(3,1,'PassengerFirstName31','PassengerLastName31','PassengerPhoneNumber31','PassengerSeatNumber31')
					,(3,2,'PassengerFirstName32','PassengerLastName32','PassengerPhoneNumber32','PassengerSeatNumber32')



-- Problem 2 

-- TPatientVisits
--	intPatientID
--	strFirstName
--	strLastName
--	dtmVisitDate01
--	strVisit01Notes(8000)
--	strVisit01Procedure01
--	…
--	strVisit01Procedure10
--	strVisit01Medication01
--	…
--	strVisit01Medication10
--	strVisit01LabTest01
--	strVisit01LabTest01Result01
--	…
--	strVisit01LabTest01Result03
--	…
--	strVisit01LabTest05
--	strVisit01LabTest05Result01
--	…
--	strVisit01LabTest05Result03
--	.
--	.
--	.
--	dtmVisitDate99
--	strVisit99Notes(8000)
--	strVisit99Procedure01
--	…
--	strVisit99Procedure10
--	strVisit99Medication01
--	…
--	strVisit99Medication10
--	strVisit99LabTest01
--	strVisit99LabTest01Result01
--	…
--	strVisit99LabTest01Result03
--	…
--	strVisit99LabTest05
--	strVisit99LabTest05Result01
--		…
--	strVisit99LabTest05Result03

										
-- --------------------------------------------------------------------------------
-- Step #2.1: Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TPatientLabTestResults 
DROP TABLE TPatientVisitLabTests
DROP TABLE TPatientVisitMedications
DROP TABLE TPatientVisitProcedures 
DROP TABLE TPatientVisits
DROP TABLE TPatients
-- --------------------------------------------------------------------------------
-- Step #2.2: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TPatients
(	
	 intPatientID						INTEGER					NOT NULL
	,strFirstName						VARCHAR(50)				NOT NULL 
	,strLastName						VARCHAR(50)				NOT NULL
	,CONSTRAINT TPatients_PK PRIMARY KEY (intPatientID) 
)
	
CREATE TABLE TPatientVisits
(
	 intPatientID						INTEGER					NOT NULL
	,intVisitIndex						INTEGER					NOT NULL
	,dtmVisitDate						DATETIME				NOT NULL 
	,strVisitNotes						VARCHAR(8000)			NOT NULL 
	,CONSTRAINT TPatientVisits_PK PRIMARY KEY (intPatientID,intVisitIndex) 
)

CREATE TABLE TPatientVisitProcedures
(
	 intPatientID						INTEGER					NOT NULL
	,intVisitIndex						INTEGER					NOT NULL	
	,intProcedureIndex					INTEGER					NOT NULL
	,strVisitProcedure					VARCHAR(50)				NOT NULL
	,CONSTRAINT TPatientVisitProcedures_PK PRIMARY KEY (intPatientID,intVisitIndex,intProcedureIndex) 
)
CREATE TABLE TPatientVisitMedications
(
	 intPatientID						INTEGER					NOT NULL
	,intVisitIndex						INTEGER					NOT NULL
	,intMedicationIndex					INTEGER					NOT NULL	
	,strVisitMedication					VARCHAR(50)				NOT NULL
	,CONSTRAINT TPatientVisitMedications_PK PRIMARY KEY (intPatientID,intVisitIndex,intMedicationIndex) 
)
CREATE TABLE TPatientVisitLabTests
(
	 intPatientID						INTEGER					NOT NULL
	,intVisitIndex						INTEGER					NOT NULL	
	,intLabTestIndex					INTEGER					NOT NULL
	,strVisitLabTests					VARCHAR(50)				NOT NULL
	,CONSTRAINT TPatientVisitLabTests_PK PRIMARY KEY (intPatientID,intVisitIndex,intLabTestIndex) 
)
CREATE TABLE TPatientVisitLabTestResults
(
	 intPatientID						INTEGER					NOT NULL
	,intVisitIndex						INTEGER					NOT NULL
	,intLabTestIndex					INTEGER					NOT NULL
	,intResultIndex						INTEGER					NOT NULL
	,strVisitLabTestResult				VARCHAR(50)				NOT NULL
	,CONSTRAINT TPatientVisitLabTestResults_PK PRIMARY KEY (intPatientID,intVisitIndex,intLabTestIndex,intResultIndex) 
)	

-- --------------------------------------------------------------------------------
-- Step #2.3: Identify And Create Foreign Keys
-- --------------------------------------------------------------------------------	
--	#				Child						Parent						Column(s)
--	--				-----						------						-------
--	1				TPatientVisits				TPatients					intPatientID
--	2				TPatientVisitProcedures		TPatientVisits				intPatientID,intVisitIndex
--	3				TPatientVisitMedications	TPatientVisits				intPatientID,intVisitIndex
--	4				TPatientVisitLabTests		TPatientVisits				intPatientID,intVisitIndex
--	5				TPatientVisitLabTestResults	TPatientVisitLabTests		intPatientID,intVisitIndex,intlabTestIndex

--	1
ALTER TABLE TPatientVisits ADD CONSTRAINT TPatientVisits_TPatients_FK 
	FOREIGN KEY (intPatientID) REFERENCES TPatients(intPatientID)

--	2	
ALTER TABLE TPatientVisitProcedures ADD CONSTRAINT TPatientVisitProcedures_TPatientVisits_FK
	FOREIGN KEY (intPatientID,intVisitIndex) REFERENCES TPatientVisits(intPatientID,intVisitIndex)

--	3
ALTER TABLE TPatientVisitMedications ADD CONSTRAINT TPatientVisitMedications_TPatientVisits_FK 
	FOREIGN KEY (intPatientID,intVisitIndex) REFERENCES TPatientVisits(intPatientID,intVisitIndex)

--	4
ALTER TABLE TPatientVisitLabTests ADD CONSTRAINT TPatientVisitLabTests_TPatientVisits_FK 
	FOREIGN KEY (intPatientID,intVisitIndex) REFERENCES TPatientVisits(intPatientID,intVisitIndex)

--	5
ALTER TABLE TPatientVisitLabTestResults ADD CONSTRAINT TPatientVisitLabTestResults_TPatientVisitLabTests_FK
	FOREIGN KEY (intPatientID,intVisitIndex,intlabTestIndex) REFERENCES TPatientVisitLabTests(intPatientID,intVisitIndex,intlabTestIndex)


-- --------------------------------------------------------------------------------
-- Step #2.4: INSERT Statements
-- --------------------------------------------------------------------------------	

INSERT INTO TPatients(intPatientID,strFirstName,strLastName)
VALUES			 (1,'FName1','LName1')
				,(2,'FName2','LName2')

INSERT INTO TPatientVisits(intPatientID,intVisitIndex,dtmVisitDate,strVisitNotes)
VALUES			  (1,1,'2001/01/01','Note11')
				 ,(1,2,'2002/02/02','Note12')
				
				 ,(2,1,'2002/02/02','Note21')
				 ,(2,2,'2002/02/02','Note22')

INSERT INTO TPatientVisitProcedures(intPatientID,intVisitIndex,intProcedureIndex,strVisitProcedure)
VALUES			   (1,1,1,'ProceudreName')
				  ,(1,1,2,'ProceudreName')
				  
				  ,(1,2,1,'ProceudreName')
				  ,(1,2,2,'ProceudreName')
				  
				  ,(2,1,1,'ProceudreName')
				  ,(2,1,2,'ProceudreName')
				  
				  ,(2,2,1,'ProceudreName')
				  ,(2,2,2,'ProceudreName') 	

INSERT INTO TPatientVisitMedications(intPatientID,intVisitIndex,intMedicationIndex,strVisitMedication)
VALUES			   (1,1,1,'MedicationName')
				  ,(1,1,2,'MedicationName')

				  ,(1,2,1,'MedicationName')
				  ,(1,2,2,'MedicationName')

				  ,(2,1,1,'MedicationName')
				  ,(2,1,2,'MedicationName')
				  
				  ,(2,2,1,'MedicationName')
				  ,(2,2,2,'MedicationName')

INSERT INTO TPatientVisitLabTests(intPatientID,intVisitIndex,intLabTestIndex,strVisitLabTests)
VALUES			   (1,1,1,'LabTest')
				  ,(1,1,2,'LabTest')

				  ,(1,2,1,'LabTest')
				  ,(1,2,2,'LabTest')

				  ,(2,1,1,'LabTest')
				  ,(2,1,2,'LabTest')

				  ,(2,2,1,'LabTest')
				  ,(2,2,2,'LabTest')

INSERT INTO TPatientVisitLabTestResults(intPatientID,intVisitIndex,intLabTestIndex,intResultIndex,strVisitLabTestResult)
VALUES			   (1,1,1,1,'LabTestResult1')
				  ,(1,1,1,2,'LabTestResult2')

				  ,(1,1,2,1,'LabTestResult1')
				  ,(1,1,2,2,'LabTestResult2')

				  ,(1,2,1,1,'LabTestResult1')
				  ,(1,2,1,2,'LabTestResult2')

				  ,(1,2,2,1,'LabTestResult1')
				  ,(1,2,2,1,'LabTestResult2')

				  ,(2,1,1,1,'LabTestResult1')
				  ,(2,1,1,2,'LabTestResult2')
				  
				  ,(2,1,2,1,'LabTestResult1')
				  ,(2,1,2,2,'LabTestResult2')
				  
				  ,(2,2,1,1,'LabTestResult1')
				  ,(2,2,1,2,'LabTestResult2')

				  ,(2,2,2,1,'LabTestResult1')
				  ,(2,2,2,2,'LabTestResult2')