drop database if exists Golfv1;
create database Golfv1;
use Golfv1;

CREATE TABLE Persons (
    PersonNumber char(13) not null,
    FullName varchar(45),
    Age int,
    primary key  (PersonNumber) 
)engine=innodb;

CREATE TABLE Jacket(
	Initials char(13) not null,
    Material varchar(45),
    Size char(5),
    PersonNumber char(13) not null,
    primary key(PersonNumber,Initials),
    foreign key(PersonNumber) references Persons(PersonNumber)
)engine=innodb;

CREATE TABLE Construction(
	SerialNumber int not null,
    Hardness float,
    primary key (SerialNumber)
)engine=innodb;

CREATE TABLE GolfClub(
	ClubNr int not null,
    Material varchar(45),
    Construction_SerialNumber int,
    PersonNumber char(13),
	primary key (PersonNumber,ClubNr),
    foreign key(PersonNumber) references Persons(PersonNumber),
    foreign key(Construction_SerialNumber) references Construction(SerialNumber)
)engine=innodb;

CREATE TABLE Competition(
	CompetitionName varchar(45) not null,
    CompetitionDate date,
    primary key(CompetitionName)
)engine=innodb;

CREATE TABLE Contestants(
	CompetitionName varchar(45) not null,
    PersonNumber char (13) not null,
    primary key(CompetitionName,PersonNumber),
    foreign key(PersonNumber) references Persons(PersonNumber),
    foreign key(CompetitionName) references Competition(CompetitionName)
)engine=innodb;

CREATE TABLE Rain(
	RainType varchar(45) not null,
    WindSpeed float,
    primary key(RainType)
)engine=innodb;

CREATE TABLE Competition_Has_Rain(
	CompetitionName varchar(45) not null,
    RainType varchar(45) not null,
    RainTime time,
    primary key (CompetitionName,RainType),
    foreign key(CompetitionName) references Competition(CompetitionName),
    foreign key(RainType) references Rain(RainType)
)engine=innodb;

INSERT INTO Persons(PersonNumber,FullName,Age) VALUES (960925,"Johan Andersson",25);
INSERT INTO Persons(PersonNumber,FullName,Age) VALUES (980721,"Nicklas Jansson",23);
INSERT INTO Persons(PersonNumber,FullName,Age) VALUES (900220,"Annika Andersson",31);
INSERT INTO Persons(PersonNumber,FullName,Age) VALUES (860301,"Sune Roos",35);
INSERT INTO Persons(PersonNumber,FullName,Age) VALUES (871214,"Amanda Bilan",33);

INSERT INTO Jacket(Initials,Material,Size,PersonNumber) VALUES("JA01","Goretex","M",960925);
INSERT INTO Jacket(Initials,Material,Size,PersonNumber) VALUES("JA02","Fleece","M",960925);
INSERT INTO Jacket(Initials,Material,Size,PersonNumber) VALUES("AB01","Fleece","S",871214);
INSERT INTO Jacket(Initials,Material,Size,PersonNumber) VALUES("AB02","Leather","S",871214);


INSERT INTO Construction(SerialNumber,Hardness) VALUES (50010,10.0);
INSERT INTO Construction(SerialNumber,Hardness) VALUES (50005,5.0);

INSERT INTO GolfClub(ClubNr,PersonNumber,Material,Construction_SerialNumber) VALUES(90,900220,"Wood",50005);
INSERT INTO GolfClub(ClubNr,PersonNumber,Material,Construction_SerialNumber) VALUES(92,980721,"Wood",50010);
INSERT INTO GolfClub(ClubNr,PersonNumber,Material,Construction_SerialNumber) VALUES(99,960925,"Wood",50010);

INSERT INTO Competition(CompetitionName,CompetitionDate) VALUES ("Big Golf Cup Skövde","2021-06-10");
INSERT INTO Competition(CompetitionName,CompetitionDate) VALUES ("Grand Prix Skara","2021-09-11");

INSERT INTO Contestants(PersonNumber,CompetitionName) VALUES (960925,"Big Golf Cup Skövde");
INSERT INTO Contestants(PersonNumber,CompetitionName) VALUES (980721,"Big Golf Cup Skövde");
INSERT INTO Contestants(PersonNumber,CompetitionName) VALUES (900220,"Big Golf Cup Skövde");
INSERT INTO Contestants(PersonNumber,CompetitionName) VALUES (860301,"Grand Prix Skara");
INSERT INTO Contestants(PersonNumber,CompetitionName) VALUES (980721,"Grand Prix Skara");
INSERT INTO Contestants(PersonNumber,CompetitionName) VALUES (871214,"Grand Prix Skara");



INSERT INTO Rain(RainType,WindSpeed) VALUES ("Hail",10.0);
INSERT INTO Rain(RainType,WindSpeed) VALUES ("Breeze",2.0);

INSERT INTO Competition_Has_Rain(CompetitionName,RainType,RainTime) VALUES("Big Golf Cup Skövde","Hail","11:58:20");
INSERT INTO Competition_Has_Rain(CompetitionName,RainType,RainTime) VALUES("Grand Prix Skara","Breeze","13:50:41");

SET SQL_SAFE_UPDATES = 0;
SELECT Age FROM Persons WHERE FullName="Johan Andersson";
SELECT CompetitionDate FROM Competition WHERE CompetitionName="Big Golf Cup Skövde";
SELECT Material FROM GolfClub WHERE PersonNumber=960925;
SELECT * FROM Jacket WHERE PersonNumber=960925;
SELECT FullName FROM Persons LEFT JOIN Contestants ON Persons.PersonNumber=Contestants.PersonNumber WHERE Contestants.CompetitionName="Big Golf Cup Skövde";
SELECT WindSpeed FROM Rain LEFT JOIN Competition_Has_Rain ON Rain.RainType=Competition_Has_Rain.RainType WHERE Competition_Has_Rain.CompetitionName="Big Golf Cup Skövde";
SELECT * FROM Persons WHERE Age < 30;
DELETE FROM Jacket WHERE PersonNumber=960925;
DELETE FROM Jacket WHERE PersonNumber=980721;
DELETE FROM Contestants WHERE PersonNumber=980721;
DELETE FROM GolfClub WHERE PersonNumber=980721;
DELETE FROM Persons WHERE PersonNumber=980721;
SELECT AVG(age) FROM Persons;