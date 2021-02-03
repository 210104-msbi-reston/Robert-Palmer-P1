use ProjectOne

-- Delete Procedures
-- Remove Product from Production House Inventory
create procedure pr_RemoveProductProdHouseInventory
(
	@serialno int
)
as
begin
	delete from ProductionHouseInventory
	where ProductSerialNo = @serialno
end

-- Remove from Warehouse Inventory
create procedure pr_RemoveProductWarehouseInventory
(
	@serialno int
)
as
begin
	delete from WarehouseInventory
	where ProductSerialNo = @serialno
end

-- Remove from Distributor Inventory
create procedure pr_RemoveProductDistributorInventory
(
	@serialno int
)
as
begin
	delete from DistributorInventory
	where ProductSerialNo = @serialno
end

-- Remove from SubDistributor Inventory
create procedure pr_RemoveProductSubDistributorInventory
(
	@serialno int
)
as
begin
	delete from SubDistributorInventory
	where ProductSerialNo = @serialno
end

-- Remove from Channel Partner Inventory
create procedure pr_RemoveProductChannelPartnerInventory
(
	@serialno int
)
as
begin
	delete from ChannelPartnerInventory
	where ProductSerialNo = @serialno
end

-- Remove from Zone Inventory
create procedure pr_RemoveProductZoneInventory
(
	@serialno int
)
as
begin
	delete from ZoneInventory
	where ProductSerialNo = @serialno
end

-- Remove from Store Inventory
create procedure pr_RemoveProductStoreInventory
(
	@serialno int
)
as
begin
	delete from StoreInventory
	where ProductSerialNo = @serialno
end


