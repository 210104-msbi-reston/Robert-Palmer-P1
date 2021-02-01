use ProjectOne

-- Trigger to add Product to Production House
create trigger tr_insertProductLog
on ProductionHouseInventory
for insert
as
begin
	Declare @serialno int
	select @serialno = ProductSerialNo from inserted
	Declare @defective bit
	set @defective = (Select Defective from Product where SerialNo=@serialno)

	if(@defective = 1)
	begin
		insert into ProductTransitLog
		values(@serialno, 'Product with Serial Number ' + cast(@serialno as varchar(20)) + ' was added to Production House at ' + CAST(GetDate() as varchar(50)))
	end
	else
	begin
		insert into ProductTransitLog
		values(@serialno, 'Product with Serial Number ' + cast(@serialno as varchar(20)) + ' was added to Production House at ' + CAST(GetDate() as varchar(50)))
	end
end

-- trigger for adding Product Log - Warehouse
create trigger tr_updateWarehouseLog
on WarehouseInventory
for insert
as
begin
	Declare @serialno int
	select @serialno = ProductSerialNo from inserted
	Declare @facilityid varchar(20)
	select @facilityid = FacilityId from inserted
	Declare @defective bit
	set @defective = (Select Defective from Product where SerialNo=@serialno)

	if(@defective = 1)
	begin
		insert into ProductTransitLog
		values(@serialno, 'Defective Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Warehouse, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
	else
	begin
		insert into ProductTransitLog
		values(@serialno, 'Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Warehouse, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
end

-- trigger for adding Product Log - Distribution
create trigger tr_updateDistributionLog
on DistributorInventory
for insert
as
begin
	Declare @serialno int
	select @serialno = ProductSerialNo from inserted
	Declare @facilityid varchar(20)
	select @facilityid = FacilityId from inserted
	Declare @defective bit
	set @defective = (Select Defective from Product where SerialNo=@serialno)

	if(@defective = 1)
	begin
		insert into ProductTransitLog
		values(@serialno, 'Defective Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Distribution, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
	else
	begin
		insert into ProductTransitLog
		values(@serialno, 'Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Distribution Store, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
end

-- trigger for adding Product Log - Sub-Distribution
create trigger tr_updateSubDistributionLog
on SubDistributorInventory
for insert
as
begin
	Declare @serialno int
	select @serialno = ProductSerialNo from inserted
	Declare @facilityid varchar(20)
	select @facilityid = FacilityId from inserted
	Declare @defective bit
	set @defective = (Select Defective from Product where SerialNo=@serialno)

	if(@defective = 1)
	begin
		insert into ProductTransitLog
		values(@serialno, 'Defective Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Sub-Distribution, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
	else
	begin
		insert into ProductTransitLog
		values(@serialno, 'Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Sub-Distribution, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
end

-- trigger for adding Product Log - Channel Partner
create trigger tr_updateChannelPartnerLog
on ChannelPartnerInventory
for insert
as
begin
	Declare @serialno int
	select @serialno = ProductSerialNo from inserted
	Declare @facilityid varchar(20)
	select @facilityid = FacilityId from inserted
	Declare @defective bit
	set @defective = (Select Defective from Product where SerialNo=@serialno)

	if(@defective = 1)
	begin
		insert into ProductTransitLog
		values(@serialno, 'Defective Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Channel Partner, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
	else
	begin
		insert into ProductTransitLog
		values(@serialno, 'Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Channel Partner, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
end

-- trigger for adding Product Log - Zone
create trigger tr_updateZoneLog
on ZoneInventory
for insert
as
begin
	Declare @serialno int
	select @serialno = ProductSerialNo from inserted
	Declare @facilityid varchar(20)
	select @facilityid = FacilityId from inserted
	Declare @defective bit
	set @defective = (Select Defective from Product where SerialNo=@serialno)

	if(@defective = 1)
	begin
		insert into ProductTransitLog
		values(@serialno, 'Defective Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Zone, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
	else
	begin
		insert into ProductTransitLog
		values(@serialno, 'Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Zone, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
end

-- trigger for adding Product Log - Store
create trigger tr_updateStoreLog
on StoreInventory
for insert
as
begin
	Declare @serialno int
	select @serialno = ProductSerialNo from inserted
	Declare @facilityid varchar(20)
	select @facilityid = FacilityId from inserted
	Declare @defective bit
	set @defective = (Select Defective from Product where SerialNo=@serialno)

	if(@defective = 1)
	begin
		insert into ProductTransitLog
		values(@serialno, 'Defective Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Store, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
	else
	begin
		insert into ProductTransitLog
		values(@serialno, 'Product with Serial Number ' + cast(@serialno as varchar(20)) + ' has shipped to Store, facility ID ' + cast(@facilityid as varchar(20)) + ' at ' + cast(getdate() as varchar(20)))
	end
end