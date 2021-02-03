use ProjectOne

-- Procedure - View Product Transit History
create procedure pr_ProductTransitHistory
(
	@serialno int
)
as
begin
	select * from ProductTransitLog
	where productSerialNo=@serialno
end

-- Procedure to Create Products
create procedure pr_CreateProduct
(
	@name varchar(30),
	@price int
)
as
begin
	insert into Product(ProductName,Price) values(@name,@price)
end

/*
	Procedures for Product being Shipped from Production House
	to Store.
*/
-- Procedure too Add Product to Production House
create procedure pr_AddProductProductionHouseInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	insert into ProductionHouseInventory
	values(@facilityno,@serialno)
end

-- Procedure to Add Product to Inventory - Warehouse
/* create procedure pr_AddProductWarehouseInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (select FacilityId from ProductionHouseInventory where ProductSerialNo=@serialno)
	Declare @receivingFacility int
	set @receivingFacility = (select ProductionHouseId from Warehouse where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Production House does not ship to Specified Warehouse Location',16,1)
	end
	else
	begin
		insert into WarehouseInventory
		values(@facilityno,@serialno)
	end
end */

-- Procedure to Add Product to Inventory - Distributor
/* alter procedure pr_AddProductDistributorInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippinglocation varchar(20)
	set @shippinglocation = (select Country from Warehouse where ID = (select FacilityId from WarehouseInventory where ProductSerialNo=@serialno))
	Declare @receivinglocation varchar(20)
	set @receivinglocation = (select Country from Distributor where ID=@facilityno)
	if(@shippinglocation <> @receivinglocation)
	begin
		Raiserror('Warehouse does not ship to Specified Distribution Location',16,1)
	end
	else
	begin
		insert into DistributorInventory
		values(@facilityno,@serialno)
	end 
end */


-- Procedure to Add Product to Inventory - Sub-Distributor
create procedure pr_AddProductSubDistributorInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (select FacilityId from DistributorInventory where ProductSerialNo=@serialno)
	Declare @receivingFacility int
	set @receivingFacility = (select DistributorId from SubDistributor where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Warehouse does not ship to Specified Distribution Location',16,1)
	end
	else
	begin
		insert into SubDistributorInventory
		values(@facilityno,@serialno)
	end
end

-- Procedure to Add Product to Inventory - Channel Partner
create procedure pr_AddProductChannelPartnerInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (select FacilityId from SubDistributorInventory where ProductSerialNo=@serialno)
	Declare @receivingFacility int
	set @receivingFacility = (select SubDistributorId from ChannelPartner where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Sub-Distributor does not ship to Specified Channel Partner Location',16,1)
	end
	else
	begin
		insert into ChannelPartnerInventory
		values(@facilityno,@serialno)
	end
end

-- Procedure to Add Product to Inventory - Zone
create procedure pr_AddProductZoneInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (select FacilityId from ChannelPartnerInventory where ProductSerialNo=@serialno)
	Declare @receivingFacility int
	set @receivingFacility = (select ChannelPartnerId from Zone where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Channel Partner does not ship to Specified Zone Location',16,1)
	end
	else
	begin
		insert into ZoneInventory
		values(@facilityno,@serialno)
	end
end

-- Procedure to Add Product to Inventory - Store
create procedure pr_AddProductStoreInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (select FacilityId from ZoneInventory where ProductSerialNo=@serialno)
	Declare @receivingFacility int
	set @receivingFacility = (select ZoneId from Store where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Zone does not ship to Specified Store Location',16,1)
	end
	else
	begin
		insert into StoreInventory
		values(@facilityno,@serialno)
	end
end

/* 
	Procedures For returning Product to Production House from
	Store Level
*/
-- Procedure to Return Product From Store to Zone
create procedure pr_ReturnProductZoneInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (Select ZoneId from Store Where Id = (Select FacilityId from StoreInventory where ProductSerialNo=@serialno))
	Declare @receivingFacility int
	set @receivingFacility = (select ID from Zone where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Store does not ship to Specified Zone Location',16,1)
	end
	else
	begin
		insert into ZoneInventory
		values(@facilityno,@serialno)
	end
end

-- Procedure to return product from Zone to Channel Partner
create procedure pr_ReturnProductChannelPartnerInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (Select ChannelPartnerId from Zone Where Id = (Select FacilityId from ZoneInventory where ProductSerialNo=@serialno))
	Declare @receivingFacility int
	set @receivingFacility = (select ID from ChannelPartner where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Zone does not ship to Specified Channel Partner Location',16,1)
	end
	else
	begin
		insert into ChannelPartnerInventory
		values(@facilityno,@serialno)
	end
end

-- Procedure to return Product from Channel Partner to Sub-Distribution
create procedure pr_ReturnProductSubDistributorInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (Select SubDistributorId from ChannelPartner Where Id = (Select FacilityId from ChannelPartnerInventory where ProductSerialNo=@serialno))
	Declare @receivingFacility int
	set @receivingFacility = (select ID from SubDistributor where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Channel Partner does not ship to Specified SubDistributor Location',16,1)
	end
	else
	begin
		insert into SubDistributorInventory
		values(@facilityno,@serialno)
	end
end

-- Procedure to return Product from Sub-Distribution to Distribution
create procedure pr_ReturnProductDistributorInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (Select DistributorId from SubDistributor Where Id = (Select FacilityId from SubDistributorInventory where ProductSerialNo=@serialno))
	Declare @receivingFacility int
	set @receivingFacility = (select ID from Distributor where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Sub Distributor does not ship to Specified Distributor Location',16,1)
	end
	else
	begin
		insert into DistributorInventory
		values(@facilityno,@serialno)
	end
end

-- Procedure to return Product from Distribution to Warehouse
/* alter procedure pr_ReturnProductWarehouseInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingLocation varchar(20)
	set @shippingLocation = (select Country from Distributor where ID=(select FacilityId from DistributorInventory where ProductSerialNo=@serialno))
	Declare @receivingLocation varchar(20)
	set @receivingLocation = (select Country from Warehouse where ID=@facilityno)
	if(@shippingLocation <> @receivingLocation)
	begin
		Raiserror('Distributor does not ship to Specified Warehouse Location',16,1)
	end
	else
	begin
		insert into WarehouseInventory
		values(@facilityno,@serialno)
	end
end */


-- Procedure to return Product from Warehouse to Production House
/* create procedure pr_ReturnProductProductionHouseInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility int
	set @shippingFacility = (Select ProductionHouseId from Warehouse Where Id = (Select FacilityId from WarehouseInventory where ProductSerialNo=@serialno))
	Declare @receivingFacility int
	set @receivingFacility = (select ID from ProductionHouse where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Warehouse does not ship to Specified Production House Location',16,1)
	end
	else
	begin
		insert into ProductionHouseInventory
		values(@facilityno,@serialno)
	end
end */

-- Procedure -- add product to warehouse if in same continent as Production House
create procedure pr_AddProductWarehouseInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility varchar(30)
	set @shippingFacility = (select Continent from ProductionHouse where ID=(select FacilityId from ProductionHouseInventory where ProductSerialNo=@serialno))
	print @shippingFacility
	Declare @receivingFacility varchar(30)
	set @receivingFacility = (select Continent from Warehouse where ID = @facilityno)
	print @receivingFacility
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Production House does not ship to Specified Warehouse Location',16,1)
	end
	else
	begin
		insert into WarehouseInventory
		values(@facilityno,@serialno)
	end
end
exec pr_AddProductWarehouseInventory @facilityno = 2, @serialno=2
select * from WarehouseInventory
select * from ProductionHouseInventory
select * from Product
-- Add Product to Distribution if Country is the same
create procedure pr_AddProductDistributorInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility varchar(30)
	set @shippingFacility = (select Country from Warehouse where ID=(select FacilityId from WarehouseInventory where ProductSerialNo=@serialno))
	Declare @receivingFacility varchar(30)
	set @receivingFacility = (select Country from Distributor where ID = @facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Warehouse does not ship to Specified Distributor Location',16,1)
	end
	else
	begin
		insert into DistributorInventory
		values(@facilityno,@serialno)
	end
end

-- Procedure - return Product from Distribution to Warehouse (same country)
create procedure pr_ReturnProductWarehouseInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility varchar(30)
	set @shippingFacility = (select Country from Distributor where ID=(select FacilityId from DistributorInventory where ProductSerialNo=@serialno))
	Declare @receivingFacility varchar(30)
	set @receivingFacility = (select Country from Warehouse where ID=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Cannot ship to Specified Location',16,1)
	end
	else
	begin
		insert into WarehouseInventory
		values(@facilityno,@serialno)
	end
end

-- procedure - Return Product from Warehouse to Production House (Same Continent)
create procedure pr_ReturnProductProductionHouseInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	Declare @shippingFacility varchar(30)
	set @shippingFacility = (select Continent from Warehouse where ID=(select FacilityId from WarehouseInventory where ProductSerialNo=@serialno))
	Declare @receivingFacility varchar(30)
	set @receivingFacility = (Select Continent from ProductionHouse where Id=@facilityno)
	if(@shippingFacility <> @receivingFacility)
	begin
		Raiserror('Cannot ship to Specified Location',16,1)
	end
	else
	begin
		insert into ProductionHouseInventory
		values(@facilityno,@serialno)
	end
end

-- Add 8% Profit Share
create procedure pr_Profit
(
	@SerialNo int
)
as
begin
	Declare @Profit money
	Declare @NewPrice money
	Declare @Price money
	set @Price = (Select Price from Product where SerialNo=@SerialNo)
	set @Profit = (@Price * 8)/100
	set @NewPrice = @Price + @Profit
	update Product set Price = @NewPrice
	where SerialNo = @SerialNo
end

create procedure pr_Manufacture
(
	@serialno int
)
as
begin
	Declare @manufacturecost money
	Declare @price money
	Declare @continent varchar(30)
	set @price = (select Price from Product where SerialNo=@serialno)
	set @continent = (select Continent from ProductionHouse where ID=(select FacilityId from ProductionHouseInventory where ProductSerialNo=@serialno))
	set @manufacturecost = (case
			when @continent = 'Asia' then 50
			when @continent = 'Africa' then 110
			when @continent = 'North America' then 200
			when @continent = 'Europe' then 75
			when @continent = 'Australia' then 180
			when @continent = 'South America' then 120
		end)
	update Product set Price= @price + @manufacturecost
	where SerialNo=@serialno
end

create procedure pr_ReturnProductInventory
(
	@facilityno int,
	@serialno int
)
as
begin
	declare @location varchar(30) = (select Cur_Location from Product where SerialNo = @serialno)
			if(@location = 'Zone')
			begin
				exec pr_ReturnProductZoneInventory @facilityno=@facilityno, @serialno=@serialno
				exec pr_RemoveProductStoreInventory @serialno=@serialno
			end
			if(@location = 'Channel Partner')
			begin
				exec pr_ReturnProductChannelPartnerInventory @facilityno=@facilityno, @serialno=@serialno
				exec pr_RemoveProductZoneInventory @serialno=@serialno
			end
			if(@location = 'Sub-Distributor')
			begin
				exec pr_ReturnProductSubDistributorInventory @facilityno=@facilityno,@serialno=@serialno
				exec pr_RemoveProductChannelPartnerInventory @serialno=@serialno
			end
			if(@location = 'Distribution')
			begin
				exec pr_ReturnProductDistributorInventory @facilityno=@facilityno,@serialno=@serialno
				exec pr_RemoveProductSubDistributorInventory @serialno=@serialno
			end
			if(@location = 'Warehouse')
			begin
				exec pr_ReturnProductWarehouseInventory @facilityno=@facilityno, @serialno=@serialno
				exec pr_RemoveProductDistributorInventory @serialno=@serialno
			end
			if(@location = 'Production House')
			begin
				exec pr_ReturnProductProductionHouseInventory @facilityno=@facilityno, @serialno=@serialno
				exec pr_RemoveProductWarehouseInventory @serialno=@serialno
			end
end

-- Procedure for Defective Products
-- Update Location, Opposite to Procedure that ships products
create procedure pr_Return_DefectiveProd
(
	@facilityno int,
	@serialNo int
)
as
begin
	Declare @defectiveProduct bit
	set @defectiveProduct = (select Defective from Product where SerialNo=@serialNo)
	Begin Try
		Begin Transaction
			if(@defectiveProduct = 1)
			begin
				update Product 
				set Cur_Location =
				(case
					when Cur_Location = 'Store' then 'Zone'
					when Cur_Location = 'Zone' then 'Channel Partner'
					when Cur_Location = 'Channel Partner' then 'Sub-Distributor'
					when Cur_Location = 'Sub-Distributor' then 'Distribution'
					when Cur_Location = 'Distribution' then 'Warehouse'
					when Cur_Location = 'Warehouse' then 'Production House'
				end)
				where SerialNo = @serialno
				exec pr_ReturnProductInventory @facilityno=@facilityno,@serialno=@serialNo
			end
		Commit Transaction
		Print 'Defective Product Successfully Shipped'
	End Try
	Begin Catch
		Rollback Transaction
		Print 'Error Returning the Product'
	End Catch
end

-- Procedure To execute adding product to inventory
create procedure pr_AddProductInventory
(
	@facilityno int,
	@serialno int
)
as
begin
		declare @location varchar(30) = (select Cur_Location from Product where SerialNo = @serialno)
			if(@location = 'Warehouse')
			begin
				exec pr_AddProductWarehouseInventory @facilityno=@facilityno,@serialno=@serialno
				exec pr_RemoveProductProdHouseInventory @serialno=@serialno
			end
			if(@location = 'Distribution')
			begin
				exec pr_AddProductDistributorInventory @facilityno=@facilityno,@serialno=@serialno
				exec pr_RemoveProductWarehouseInventory @serialno=@serialno
			end
			if(@location = 'Sub-Distributor')
			begin
				exec pr_AddProductSubDistributorInventory @facilityno=@facilityno,@serialno=@serialno
				exec pr_RemoveProductDistributorInventory @serialno=@serialno
			end
			if(@location = 'Channel Partner')
			begin
				exec pr_AddProductChannelPartnerInventory @facilityno=@facilityno,@serialno=@serialno
				exec pr_RemoveProductSubDistributorInventory @serialno=@serialno
			end
			if(@location = 'Zone')
			begin
				exec pr_AddProductZoneInventory @facilityno=@facilityno,@serialno=@serialno
				exec pr_RemoveProductChannelPartnerInventory @serialno=@serialno
			end
			if(@location = 'Store')
			begin
				exec pr_AddProductStoreInventory @facilityno=@facilityno,@serialno=@serialno
				exec pr_RemoveProductZoneInventory @serialno=@serialno
			end
end

-- Procedure to Ship products
-- Update Location (if current location is warehouse, update only to distributor, etc)
create procedure pr_shipProduct
(
	@facilityno int,
	@serialno int
)
as
begin
	Begin Try
		Begin Transaction
			update Product 
			set Cur_Location =
			(case
				when Cur_Location = 'Production House' then 'Warehouse'
				when Cur_Location = 'Warehouse' then 'Distribution'
				when Cur_Location = 'Distribution' then 'Sub-Distributor'
				when Cur_Location = 'Sub-Distributor' then 'Channel Partner'
				when Cur_Location = 'Channel Partner' then 'Zone'
				when Cur_Location = 'Zone' then 'Store'
			end)
			where SerialNo = @serialno
			exec pr_AddProductInventory @facilityno=@facilityno, @serialno=@serialno
			exec pr_Profit @SerialNo = @serialno
		Commit Transaction
		Print 'Product shipped successfully'
	End Try
	Begin Catch
		Rollback Transaction
		Print 'Error shipping Product'
	End Catch
end

-- Update Product to Defective
create procedure pr_Defective
(
	@facilityno int,
	@serialno int
)
as
begin
	-- Grab location from purchased and match with requested store as well--
	Declare @receivinglocation varchar(30)
	set @receivinglocation = (select City from Store where ID=@facilityno)
	Declare @purchaselocation varchar(30)
	set @purchaselocation = (select City from Customer where SSN=(select CustomerId from Purchased where SerialNo=@serialno))
	Declare @location varchar(20)
	set @location = (select Cur_Location from Product where SerialNo = @serialno)

	if(@location <> 'Purchased' OR @receivinglocation <> @purchaselocation)
	begin
		raiserror('Cannot Return Specified Product',16,1)
	end
	else
	begin
		Begin try
			Begin Transaction
				update Product set Defective=1,Cur_Location='Store'
				where SerialNo = @serialno
				exec pr_AddProductStoreInventory @facilityno=@facilityno,@serialno=@serialno
			Commit Transaction
		End Try
		Begin Catch
			Rollback Transaction
		End Catch
	end
end


-- Procedure To Purchase Product
create procedure pr_Purchase_Product
(
	@serialno int,
	@customerid int
)
as
begin
	Declare @customerlocation varchar(30)
	set @customerlocation = (select City from Customer where SSN=@customerid)
	Declare @productlocation varchar(30)
	set @productlocation = (select City from Store where ID=(select FacilityId from StoreInventory where ProductSerialNo=@serialno))
	if(@customerlocation <> @productlocation)
	begin
		Raiserror('Cannot Purchase product from location',16,1)
	end
	else
	begin
		Begin Try
			Begin Transaction
				update Product set Cur_Location = 'Purchased'
				where SerialNo=@serialno
				insert into Purchased(SerialNo,CustomerId) values(@serialno,@customerid)
				exec pr_RemoveProductStoreInventory @serialno=@serialno
			Commit Transaction
		End Try
		Begin Catch
			Rollback Transaction
		End Catch
	end
end