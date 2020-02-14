drop table if exists flights; 
create table flights (
	id serial primary key,
	flight_from varchar(255),
	flight_to varchar(255),
	foreign key (flight_from) references cities(label),
	foreign key (flight_to) references cities(label)
);

insert into flights (flight_from, flight_to) values
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');

drop table if exists cities; 
create table cities (
	label varchar(255) primary key,
	name varchar(255)
);

insert into cities (label, name) values
	('moscow', 'москва'),
	('irkutsk', 'иркутск'),
	('novgorod', 'новгород'),
	('kazan', 'казань'),
	('omsk', 'омск');


select
	f.id,
	cities_from.name,
	cities_to.name
from flights f
join cities as cities_from on f.flight_from = cities_from.label
join cities as cities_to on f.flight_to = cities_to.label


select
	id,
	(select name from cities where label = flights.flight_from) as flight_from,
	(select name from cities where label = flights.flight_to) as flight_to
from flights