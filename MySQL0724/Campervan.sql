
use carrent;


-- 캠핑카
create table RV( 
	rv_id integer not null primary key,
    com_id integer not null,
    rv_name char(20) not null,
    rv_nofp integer not null,
    rv_image varchar(100) not null,
    rv_detail varchar(255) not null,
    rv_price integer not null,
    rv_date date
);

-- 캠핑카대여회사
create table Rental_Company(
	com_id integer not null primary key,
	com_name char(20) not null,
    com_address varchar(100) not null,
    com_phone char(20) not null,
    com_manager_name char(30) not null,
    com_manager_email char(30) not null
);

-- 캠핑카정비소
create table Repair_Shop(
	shop_id integer not null primary key,
	shop_name char(20) not null,
    shop_address varchar(100) not null,
    shop_phone char(20) not null,
    shop_manager_name char(30) not null,
    shop_manager_email char(30) not null
);

-- 캠핑카정비정보
create table Maintence_Info(
	maintence_num  integer not null primary key,
    rv_id integer not null,
    shop_id integer not null,
    com_id integer not null,
    driver_license varchar(100) not null,
    maintence_log char(20),
    maintence_repair_date date,
    maintence_repair_price integer not null,
    maintence_due_date date,
    other_repair_log varchar(255)
);


-- 캠핑카대여
create table Rental(
	rental_num integer not null primary key,
    rv_id integer not null,
    driver_license varchar(100) not null,
    com_id integer not null,
    rental_date date not null,
    rental_period varchar(100) not null,
    rental_charge integer not null,
    rental_duedate date not null,
    other_charges_Details varchar(100),
    other_charges_fee integer
);

-- 고객
create table Customer(
	driver_license varchar(100) not null primary key,
	customer_name char(20) not null,
    customer_address varchar(100) not null,
    customer_phone char(20) not null,
    customer_email char(30) not null,
    previous_date date,
    previous_rv_type varchar(50) not null
);


alter table Rv add foreign key (com_id) references Rental_Company (com_id);

alter table Rental add foreign key (rv_id) references RV (com_id);
alter table Rental add foreign key (driver_license) references Customer (driver_license);
alter table Rental add foreign key (com_id) references RV (com_id);

alter table Maintence_Info add foreign key (rv_id) references RV (rv_id);
alter table Maintence_Info add foreign key (driver_license) references Customer (driver_license);
alter table Maintence_Info add foreign key (com_id) references RV (com_id);
alter table Maintence_Info add foreign key (shop_id) references Repair_shop (shop_id);



-- alter table RV drop foreign key RV_ibfk_1;

-- alter table Rental drop foreign key Rental_ibfk_1;
-- alter table Rental drop foreign key Rental_ibfk_2;
-- alter table Rental drop foreign key Rental_ibfk_3;

-- alter table Maintence_Info drop foreign key Maintence_Info_ibfk_1;
-- alter table Maintence_Info drop foreign key Maintence_Info_ibfk_2;
-- alter table Maintence_Info drop foreign key Maintence_Info_ibfk_3;
-- alter table Maintence_Info drop foreign key Maintence_Info_ibfk_4;


-- drop table if exists RV;
-- drop table if exists Rental_Company;
-- drop table if exists Repair_Shop;
-- drop table if exists Maintence_Info;
-- drop table if exists Rental;
-- drop table if exists Customer;

