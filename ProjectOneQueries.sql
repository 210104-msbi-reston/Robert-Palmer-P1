use ProjectOne

-- Views to display inventory of each location
-- Production House
create view v_ProductionHouseInventory as
select FacilityId as [Facility ID],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from ProductionHouseInventory
inner join Product
on ProductionHouseInventory.ProductSerialNo = Product.SerialNo

-- Warehouse
create view v_WarehouseInventory as
select FacilityId as [Facility ID],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from WarehouseInventory
inner join Product
on WarehouseInventory.ProductSerialNo = Product.SerialNo

-- Distributor
create view v_DistributorInventory as
select FacilityId as [Facility ID],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from DistributorInventory
inner join Product
on DistributorInventory.ProductSerialNo = Product.SerialNo

-- SubDistributor
create view v_SubDistributorInventory as
select FacilityId as [Facility ID],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from SubDistributorInventory
inner join Product
on SubDistributorInventory.ProductSerialNo = Product.SerialNo

-- Channel Partner
create view v_ChannelPartnerInventory as
select FacilityId as [Facility ID],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from ChannelPartnerInventory
inner join Product
on ChannelPartnerInventory.ProductSerialNo = Product.SerialNo

-- Zone
create view v_ZoneInventory as
select FacilityId as [Facility ID],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from ZoneInventory
inner join Product
on ZoneInventory.ProductSerialNo = Product.SerialNo

-- Store
create view v_StoreInventory as
select FacilityId as [Facility ID],
	   ProductSerialNo as [Product Serial Number],
	   ProductName as [Product Name],
	   Price as [Price],
	   Cur_Location as [Location],
	   Defective as [Defective]
from StoreInventory
inner join Product
on StoreInventory.ProductSerialNo = Product.SerialNo