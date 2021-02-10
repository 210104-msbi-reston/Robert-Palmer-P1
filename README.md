# PROJECT NAME
Device Manufacturer Database

## Project Description
This project provides an implementation to allow products to ship through a supply chain, starting from Production Houses to Stores. 

## Technologies Used

* T-SQL
* SQL Server Management Studio
* SQL Server Integration Services
* SQL

## Features

* Stored procedures to ship products to each facility down the supply chain
* Triggers that add to log that keeps a history of where the product was shipped
* Views that display product information and facility inventory
* Utilitzes Integration Services to fetch from excel sources

To-do list:
* Reorganize facilites by relating them to location and not store number
* add more data for both products and facilities

## Getting Started
   
This project was created using SQL Server Management Studio 2016(with SQL Server Integration Services), and Visual Studio 2017.

- In the command prompt, use this command to clone repo onto local repository:
    git clone https://github.com/210104-msbi-reston/Robert-Palmer-P1.git

- Open SQL Server Management Studio
- Highlight each table, trigger, procedure, and view, and click execute
- Open Visual Studio (SSDT)

## Usage

> The main functionality of the project is facilitated using the procedure pr_ShipProduct. You can specify which product to ship by providing its serial number, along with which facility to ship the product to by specifying the facility location.

## License

This project uses the following license: [<SQL Server Management Studio>](<https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15>).
