
-- CREATE DATABASE Uber_System;
-- \c Uber_System

CREATE TABLE Type (
  model text NOT NULL PRIMARY KEY,
  uber_type VARCHAR(15) NOT NULL
);

CREATE TABLE Driver (
  did VARCHAR(10) NOT NULL PRIMARY KEY, --- Primary key
  model text NOT NULL REFERENCES Type (model),      --- Foreign key
  d_fname VARCHAR(15) NOT NULL,
  d_lname VARCHAR(15) NOT NULL,
  dphone_num VARCHAR(20) NOT NULL, 
  licence_plate VARCHAR(10) NOT NULL,
  color text NOT NULL
);

-------------------------------------------------

CREATE TABLE Rider (
  rid VARCHAR(10) NOT NULL PRIMARY KEY, -- Primary key
  r_fname VARCHAR(15) NOT NULL,
  r_lname VARCHAR(15) NOT NULL,
  rphone_num VARCHAR(20) NOT NULL,
  credit_card VARCHAR(20) NOT NULL,
  email text NOT NULL,
  ride_credit INTEGER NOT NULL,
  referrer VARCHAR(10) NULL,
  ref_date DATE NULL,
  ref_method VARCHAR(5) NULL
);

CREATE TABLE Business_Rider (
  rid VARCHAR(10) NOT NULL PRIMARY KEY, -- Primary key
  company_name text NOT NULL
);

-------------------------------------------------

CREATE TABLE Trip_Details (
  tdid VARCHAR(10) NOT NULL PRIMARY KEY, --- Primary key
  start_datetime TIMESTAMP NOT NULL,
  end_datetime TIMESTAMP NOT NULL,
  loc_start_lat FLOAT NOT NULL,
  loc_start_long FLOAT NOT NULL,
  loc_end_lat FLOAT NOT NULL,
  loc_end_long FLOAT NOT NULL,
  request_datetime TIMESTAMP NOT NULL,
  -- request_time TIME NOT NULL,
  request_type VARCHAR(15) NOT NULL
);

CREATE TABLE Trip (
  tid VARCHAR(10) NOT NULL PRIMARY KEY,  --- Primary key
  did VARCHAR(10) NOT NULL REFERENCES Driver (did),  --- Foreign key
  rid VARCHAR(10) NOT NULL REFERENCES Rider (rid),  --- Foreign key
  tdid VARCHAR(10) NOT NULL REFERENCES Trip_Details (tdid), --- Foreign key
  -- start_date date NOT NULL,
  payment_date date NOT NULL,
  cost FLOAT NOT NULL
);

------------------------------------------------

CREATE TABLE Rating (
  rating_id VARCHAR(10) NOT NULL PRIMARY KEY, --- Primary key
  did VARCHAR(10) NOT NULL REFERENCES Driver (did), --- Foreign key
  rid VARCHAR(10) NOT NULL REFERENCES Rider (rid), --- Foreign key
  tid VARCHAR(10) NOT NULL REFERENCES Trip (tid),  --- Foreign key
  driver_score INTEGER  NOT NULL,
  rider_score INTEGER NOT NULL
);

CREATE TABLE Rider_Rating (
   rating_id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES Rating, --- Primary key
   driver_complaint text NOT NULL 
);

CREATE TABLE Driver_Rating (
  rating_id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES Rating, --- Primary key
  rider_complaint text NOT NULL
);

-------------------------------------------------