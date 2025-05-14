CREATE DATABASE pet_adoption;
USE pet_adoption;

CREATE TABLE Species (
    SpeciesID      INT UNSIGNED AUTO_INCREMENT,
    SpeciesName    VARCHAR(30)  NOT NULL,
    Breed          VARCHAR(30)  NOT NULL,
    Size           ENUM('S','M','L') NOT NULL,
    PRIMARY KEY (SpeciesID)
);

CREATE TABLE Pets (
    PetID       INT UNSIGNED AUTO_INCREMENT,
    Name        VARCHAR(25)  NOT NULL,
    DateOfBirth DATE,
    Gender      ENUM('M','F') NOT NULL,
    Color       VARCHAR(20),
    IntakeDate  DATE,
    Status      ENUM('Available','Adopted','Fostering') DEFAULT 'Available',
    SpeciesID   INT UNSIGNED,
    PRIMARY KEY (PetID),
    CONSTRAINT fk_PetsSpecies
        FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Vaccinations (
    VaccinationID INT UNSIGNED AUTO_INCREMENT,
    PetID         INT UNSIGNED NOT NULL,
    VaccineName   VARCHAR(30)  NOT NULL,
    DateGiven     DATE         NOT NULL,
    NextDue       DATE,
    PRIMARY KEY (VaccinationID),
    CONSTRAINT fk_VaccPet
        FOREIGN KEY (PetID) REFERENCES Pets(PetID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Sterilization (
    SterilizationID INT UNSIGNED AUTO_INCREMENT,
    PetID           INT UNSIGNED NOT NULL UNIQUE,
    Status          ENUM('Spayed','Neutered','Intact') NOT NULL,
    DatePerformed   DATE,
    Veterinarian    VARCHAR(40),
    PRIMARY KEY (SterilizationID),
    CONSTRAINT fk_SterPet
        FOREIGN KEY (PetID) REFERENCES Pets(PetID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Adopters (
    AdopterID  INT UNSIGNED AUTO_INCREMENT,
    FirstName  VARCHAR(25) NOT NULL,
    LastName   VARCHAR(25) NOT NULL,
    Phone      VARCHAR(15),
    Email      VARCHAR(50),
    Street     VARCHAR(50),
    City       VARCHAR(30),
    State      CHAR(2),
    Zip        VARCHAR(10),
    PRIMARY KEY (AdopterID)
);

CREATE TABLE Employees (
    EmployeeID INT UNSIGNED AUTO_INCREMENT,
    FirstName  VARCHAR(25) NOT NULL,
    LastName   VARCHAR(25) NOT NULL,
    Role       VARCHAR(30),
    HireDate   DATE,
    PRIMARY KEY (EmployeeID)
);

CREATE TABLE Adoptions (
    AdoptionID   INT UNSIGNED AUTO_INCREMENT,
    PetID        INT UNSIGNED NOT NULL,
    AdopterID    INT UNSIGNED NOT NULL,
    AdoptionDate DATE NOT NULL,
    AdoptionFee  DECIMAL(7,2) NOT NULL,
    EmployeeID   INT UNSIGNED NOT NULL,
    PRIMARY KEY (AdoptionID),
    CONSTRAINT fk_AdoptPet     FOREIGN KEY (PetID)     REFERENCES Pets(PetID)
                               ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_AdoptAdopter FOREIGN KEY (AdopterID) REFERENCES Adopters(AdopterID)
                               ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_AdoptEmp     FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
                               ON UPDATE CASCADE ON DELETE RESTRICT
);


/* Sample data */

/* ---------- Species */
INSERT INTO Species 
(SpeciesName, Breed, Size) VALUES
('Dog', 'Labrador Retriever','L'),
('Dog', 'Beagle','M'),
('Cat', 'Domestic Shorthair','S'),
('Rabbit','Dutch','S'),
('Dog', 'Chihuahua','S'),
('Cat', 'Maine Coon','L');

/* ---------- Pets */
INSERT INTO Pets 
(Name, DateOfBirth, Gender, Color, IntakeDate, Status, SpeciesID) VALUES
('Buddy', '2023-03-15','M','Black','2024-02-10','Available',1),
('Daisy', '2022-12-05','F','Brown','2024-01-20','Adopted',3),
('Max',   '2021-07-01','M','Yellow','2023-11-30','Fostering',2),
('Luna',  '2023-05-25','F','White','2024-03-18','Available',4),
('Coco',  '2020-10-10','F','Tan','2023-09-05','Adopted',5),
('Simba', '2022-08-12','M','Orange','2024-02-28','Available',6),
('Rocky', '2021-04-04','M','Brindle','2024-04-01','Available',1),
('Bella', '2020-02-14','F','Black','2023-12-22','Adopted',3);

/* ---------- Vaccinations */
INSERT INTO Vaccinations 
(PetID, VaccineName, DateGiven, NextDue) VALUES
(1,'DHPP','2024-02-12','2025-02-12'),
(1,'Rabies','2024-02-12','2027-02-12'),
(2,'FVRCP','2024-01-22','2025-01-22'),
(3,'DHLPP','2023-12-02','2024-12-02'),
(4,'RHD','2024-03-20','2025-03-20'),
(5,'Rabies','2023-09-10','2026-09-10'),
(6,'FVRCP','2024-03-01','2025-03-01'),
(7,'DHPP','2024-04-02','2025-04-02'),
(8,'FVRCP','2023-12-24','2024-12-24');

/* ---------- Sterilization */
INSERT INTO Sterilization 
(PetID, Status, DatePerformed, Veterinarian) VALUES
(2,'Spayed','2024-01-25','Dr Hayes'),
(3,'Neutered','2023-12-04','Dr Nguyen'),
(4,'Intact',NULL,NULL),
(5,'Spayed','2023-09-12','Dr Kim'),
(6,'Neutered','2024-03-02','Dr Thompson');

/* ---------- Adopters */
INSERT INTO Adopters
(FirstName, LastName, Phone, Email, Street, City, State, Zip) VALUES
('Maria','Lopez','212-555-0100','maria.lopez@example.com','123 Maple St','Bronx','NY','10460'),
('Jason','Patel','347-555-0022','jpatel@gmail.com','88 Highland Ave','Queens','NY','11375'),
('Emily','Chen','917-555-0134','echen@yahoo.com','452 Parkside Blvd','Brooklyn','NY','11226'),
('Ahmed','Hassan','646-555-0199','a.hassan@outlook.com','901 East 170th St','Bronx','NY','10456'),
('Sarah','O\'Neill','718-555-0211','sarah.oneill@aol.com','22 Forest Lane','Staten Island','NY','10301');

/* ---------- Employees */
INSERT INTO Employees 
(FirstName, LastName, Role, HireDate) VALUES
('Olivia','Rivera','Adoption Counselor','2022-06-15'),
('Miguel','Torres','Vet Technician','2021-09-28'),
('Hannah','Singh','Shelter Manager','2019-03-11');

/* ---------- Adoptions */
INSERT INTO Adoptions 
(PetID, AdopterID, AdoptionDate, AdoptionFee, EmployeeID) VALUES
(2,1,'2024-01-30',125.00,1),
(5,3,'2023-09-15',100.00,2),
(8,4,'2023-12-28', 75.00,1);