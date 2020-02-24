/* 6.1 В базе данных shop и sample присутствуют одни и те же таблицы, 
 учебной базы данных. Переместите запись id = 1 из таблицы shop.users 
 в таблицу sample.users. Используйте транзакции.
*/


start transaction;
insert into sample.users select * from shop.users where id = 1;
delete from shop.users where id = 1;
commit;

/* 6.2 Создайте представление, которое выводит название name товарной позиции 
из таблицы products и соответствующее название каталога name из таблицы catalogs.
 */

create or replace view prod_in_cat (`product`, `catalog`)
as select products.name, catalogs.name from
products join catalogs on products.catalog_id = catalogs.id;
select * from prod_in_cat pic


/* 6.3 Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые 
календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
Составьте запрос, который выводит полный список дат за август, выставляя в соседнем 
поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
 */

drop table if exists random;
create table random(
	id serial primary key,
	name varchar(255),
	created_at datetime not null
);

drop table if exists days_in_august;
create temporary table days_in_august (
	`date` int
);

insert into days_in_august (`date`)
values (0), (1), (2), (3), (4), (5), (6), (7), (8),
(9), (10), (11), (12), (13), (14), (15), (16), (17), (18),
(19), (20), (21), (22), (23), (24), (25), (26), (27), (28),
(29), (30);

select date(date('2018-08-31') - interval au.`date` day) as `day`,
not isnull(ra.name) as order_exist
from days_in_august as au
left join random as ra
on date(date('2018-08-31') - interval au.`date` day) = ra.created_at
order by au.`date` desc


/*6.4 Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, 
который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
 */

start transaction;
prepare prod_del from 'delete from products order by created_at limit ?';
set @total = (select count(*) - 5 from products);
execute prod_del using @total;
commit;






