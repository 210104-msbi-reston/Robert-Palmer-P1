use ProjectOne

-- Views to display inventory of each location
-- Production House
alter view v_ProductionHouseInventory as
select FacilityId as [Facility ID],
	   Continent as [Continent],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from ProductionHouse
join ProductionHouseInventory
on ProductionHouse.ID = ProductionHouseInventory.FacilityId
join Product
on Product.SerialNo = ProductionHouseInventory.ProductSerialNo

-- Warehouse
alter view v_WarehouseInventory as
select FacilityId as [Facility ID],
	   Country as [Country],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from Warehouse join WarehouseInventory
on Warehouse.ID = WarehouseInventory.FacilityId
join Product
on WarehouseInventory.ProductSerialNo = Product.SerialNo

-- Distributor
alter view v_DistributorInventory as
select FacilityId as [Facility ID],
	   Country as [Country],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from Distributor join DistributorInventory
on Distributor.ID = DistributorInventory.FacilityId
join Product
on DistributorInventory.ProductSerialNo = Product.SerialNo

-- SubDistributor
alter view v_SubDistributorInventory as
select FacilityId as [Facility ID],
	   Country as [Country],
	   DistributorId as [Distributor Facility],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from SubDistributor join SubDistributorInventory
on SubDistributor.ID = SubDistributorInventory.FacilityId
join Product
on Product.SerialNo = SubDistributorInventory.ProductSerialNo

-- Channel Partner
alter view v_ChannelPartnerInventory as
select FacilityId as [Facility ID],
	   Country as [Country],
	   SubDistributorId as [Sub Distributor Facility],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from ChannelPartner join ChannelPartnerInventory
on ChannelPartner.ID = ChannelPartnerInventory.FacilityId
join Product
on Product.SerialNo = ChannelPartnerInventory.ProductSerialNo

-- Zone
alter view v_ZoneInventory as
select FacilityId as [Facility ID],
	   Country as [Country],
	   ChannelPartnerId as [Channel Partner Facility],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from Zone join ZoneInventory
on Zone.ID = ZoneInventory.FacilityId
join Product
on Product.SerialNo = ZoneInventory.ProductSerialNo

-- Store
alter view v_StoreInventory as
select FacilityId as [Facility ID],
	   ZoneId as [Zone Facility ID],
	   Country as [Country],
	   City as [City],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from Store join StoreInventory
on Store.ID = StoreInventory.FacilityId
join Product
on Product.SerialNo = StoreInventory.ProductSerialNo

-- Views For Facility Information
-- Production House
create view v_ProductionHouses as
	Select ID as [Facility ID],
	Continent as [Continent]
	from ProductionHouse

-- Warehouse
create view v_Warehouses as
	Select ID as [Warehouse ID],
	Country as [Country]
	from Warehouse

create view v_Distributors as
	Select ID as [Distributor ID],
	Country as [Warehouse Country]
	from Distributor

alter view v_SubDistributors as
	Select ID as [Sub-Distributor ID],
	DistributorId as [Distribution Facility ID],
	Country as [Country]
	from SubDistributor

create view v_ChannelPartners as
	Select Id as [Channel Partner ID],
	SubDistributorId as [Sub-Distributor ID],
	Country as [Country]
	from ChannelPartner

create view v_Zones as
	Select ID as [Zone ID],
	ChannelPartnerId as [Channel Partner ID],
	Country as [Country]
	from Zone

create view v_Stores as
	Select ID as [Store ID],
	ZoneId as [Zone ID],
	City as [City]
	from Store
