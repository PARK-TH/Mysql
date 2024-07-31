
create user ssgdoctor@localhost identified by 'Mysql1234!?';

create database hospital;


create database hospital;

grant all privileges on ssgdoctor.* to ssgdoctor@localhost with grant option;

use hospital;

create table doctor(
doctor_id integer not null primary key,
subject varchar(20) not null,
name char(15) not null,
gender char(3) not null,
phone integer,
email varchar(20),
position char(5)
);


create table clinic(
clinic_id integer not null primary key,
patient_id integer not null,
doctor_id integer not null,
clinic_content varchar(100) not null,
clinic_day date not null
);

create table chart(
chart_number integer not null primary key,
clinic_id integer not null,
doctor_id integer not null,
patient_id integer not null,
nurse_id integer not null,
chart_content varchar(100) not null
);

create table patient(
patient_id integer not null primary key,
nurse_id integer not null,
doctor_id integer not null,
patient_name char(20) not null,
patient_gender char(3) not null,
rrn char(14) not null,
address varchar(30) not null,
phone integer,
email varchar(20),
job char(10)
);

create table nurse(
nurse_id integer not null primary key,
responsibilities char(10) not null,
name char(15) not null,
gender char(3) not null,
phone integer,
email varchar(20),
position char(5)
);

alter table clinic add foreign key (patient_id) references doctor (patient_id);
alter table clinic add foreign key (doctor_id) references patient (doctor_id);

alter table patient add foreign key (nurse_id) references clinic (nurse_id);
alter table patient add foreign key (doctor_id) references clinic (doctor_id);

alter table chart add foreign key (clinic_id) references clinic (clinic_id);
alter table chart add foreign key (doctor_id) references clinic (doctor_id);
alter table chart add foreign key (patient_id) references clinic (patient_id);
alter table chart add foreign key (nurse_id) references clinic (nurse_id);


