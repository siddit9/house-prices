create database if not exists house_price_data;
use house_price_data;
create table if not exists house_prices (
	house_num int not null primary key,
	price int not null,
    area int not null,
    bedrooms int not null,
    bathrooms int not null,
    stories int not null,
    mainroad varchar(3) not null,
    guestrooms varchar(3) not null,
    basement varchar(3) not null,
    renting_boiler varchar(3) not null,
    parking int not null,
    air_conditioning varchar(3) not null,
    furnished varchar(14) not null
    );

-- How many bathrooms are the most common?
CREATE TABLE bathroom_counts (
    bathrooms INT NOT NULL,
    count INT NOT NULL
);
use house_price_data;
insert into bathroom_counts (bathrooms, count)
select bathrooms, COUNT(*) AS count
from house_prices group by bathrooms order by count desc;

-- What is the price distribution based on the number of bedrooms?
CREATE TABLE bedroom_prices (
    bedrooms INT NOT NULL,
    average_price INT NOT NULL
);
use house_price_data;
insert into bedroom_prices (bedrooms, average_price)
select bedrooms, avg(price) as average_price
from house_prices group by bedrooms order by average_price desc;

-- What is the average price of houses with basement vs no basement?
CREATE TABLE basement_prices (
    basement varchar(3) NOT NULL,
    average_price INT NOT NULL
);
use house_price_data;
insert into basement_prices
select basement, avg(price) as average_price
from house_prices
group by basement;

-- Are houses with air conditioning generally larger in area compared to those without?
CREATE TABLE ac_area (
    air_conditioning varchar(3) NOT NULL,
    average_price INT NOT NULL
);
use house_price_data;
insert into ac_area
select air_conditioning, avg(area) as average_area
from house_prices
group by air_conditioning;

-- How does the number of stories affect the average area and average price?
CREATE TABLE stories_price (
    stories INT NOT NULL,
    average_price INT NOT NULL,
    average_area INT NOT NULL
);
use house_price_data;
insert into stories_price
select stories, avg(price) as average_price, avg(area) as average_area
from house_prices group by stories order by stories desc;

-- How much does parking increase a house’s price by?
CREATE TABLE parking_prices (
    parking varchar(3) NOT NULL,
    average_price INT NOT NULL
);