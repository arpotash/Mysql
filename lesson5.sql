-- 3 задание

update users
set created_at = now(), updated_at = now();

update users
set created_at = str_to_date(created_at, '%d.%m.%Y %k:%i'), updated_at = str_to_date(updated_at, '%d.%m.%Y %k:%i');
alter table users modify column created_at datetime;
alter table users modify column updated_at datetime;

select id, value from storehouses_products order by if(value > 0, 0, 1), value;

select id, name, date_format(birthday_at, '%M') from users where month(birthday_at) in ('05', '08');

select name, id, if(name like 'М%', 1,0) as sort from catalogs where id in(5,1,2) order by sort, id desc;

-- 4 задание

select avg(timestampdiff(year, birthday_at, now())) from users;

select date_format(date(concat_ws('-', year(now()), month(birthday_at), day(birthday_at))),'%W') as day_of_week, count(*) as count_bd from users group by day_of_week order by count_bd;
