-- Page to create all tables
create database ProjectOne
use ProjectOne

-- Tables
create table Product
(
	SerialNo int primary key,
	ProductName varchar(30) not null,
	Price money not null,
	Cur_Location varchar(30) default 'Production House',
	Defective bit default 0
)

-- Customer Table
create table Customer
(
	SSN int identity primary key,
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	City varchar(20) not null
);

create table Purchased
(
	ID int identity primary key,
	SerialNo int foreign key references Product(SerialNo),
	CustomerId int foreign key references Customer(SSN)
);

-- Production House Table
create table ProductionHouse
(
	ID int identity primary key,
	Continent varchar(30),
	constraint CHK_Continent check (Continent in ('Asia','Africa','North America','South America','Europe','Australia'))
);
-- Production House Inventory
create table ProductionHouseInventory
(
	ID int identity primary key,
	FacilityId int foreign key references ProductionHouse(ID),
	ProductSerialNo int foreign key references Product(SerialNo) unique
);

-- WareHouse Table
create table Warehouse
(
	ID int identity primary key,
	ProductionHouseId int foreign key references ProductionHouse(ID),
	Country varchar(20),
	Continent varchar(30),
	constraint CHK_Continent_Warehouse check (Continent in ('Asia','Africa','North America','South America','Europe','Australia'))
);

-- WareHouse Inventory Table
create table WarehouseInventory
(
	ID int identity primary key,
	FacilityId int foreign key references Warehouse(ID),
	ProductSerialNo int foreign key references Product(SerialNo) unique
);

-- Distributor Table
create table Distributor
(
	ID int identity primary key,
	WarehouseId int foreign key references Warehouse(ID),
	Country varchar(20)
);

-- Distributor Inventory Table
create table DistributorInventory
(
	ID int identity primary key,
	FacilityId int foreign key references Distributor(ID),
	ProductSerialNo int foreign key references Product(SerialNo) unique
);

-- SubDistributor Table
create table SubDistributor
(
	ID int identity primary key,
	DistributorId int foreign key references Distributor(ID),
	Country varchar(20)
);

-- SubDistributorInventory Table
create table SubDistributorInventory
(
	ID int identity primary key,
	FacilityId int foreign key references SubDistributor(ID),
	ProductSerialNo int foreign key references Product(SerialNo) unique
);

-- ChannelPartner Table
create table ChannelPartner
(
	ID int identity primary key,
	SubDistributorId int foreign key references SubDistributor(ID),
	Country varchar(20)
);

-- ChannelPartnerInventory Table
create table ChannelPartnerInventory
(
	ID int identity primary key,
	FacilityId int foreign key references ChannelPartner(ID),
	ProductSerialNo int foreign key references Product(SerialNo) unique
);

-- Zone Table
create table Zone
(
	ID int identity primary key,
	ChannelPartnerId int foreign key references ChannelPartner(ID),
	Country varchar(20)
);

-- ZoneInventory Table
create table ZoneInventory
(
	ID int identity primary key,
	FacilityId int foreign key references Zone(ID),
	ProductSerialNo int foreign key references Product(SerialNo) unique
);

-- Store Table
create table Store
(
	ID int identity primary key,
	ZoneId int foreign key references Zone(ID),
	Country varchar(20),
	City varchar(20)
);

-- StoreInventory Table
create table StoreInventory
(
	ID int identity primary key,
	FacilityId int foreign key references Store(ID),
	ProductSerialNo int foreign key references Product(SerialNo) unique
);

create table ProductTransitLog
(
	ID int identity primary key,
	productSerialNo int,
	transitLog varchar(255)
)