-- выборка основной информации о пользователе

select u.firstname, u.lastname, p.email, p.gender, p.homecity, p.phone
from users u
join profile p on u.id = p.user_id

-- выборка всех услуг, приобретенных пользователем

select u.id, u.firstname, u.lastname, se.name, se.price, sc.name
from users u
join payment py on u.id = py.user_id
join services se on py.services_id = se.id
join services_category sc on se.category_service_id = sc.id
where u.id = 1

-- количество активных документов у каждого пользователя

select count(d2.is_confirmed) as count_activity_docs , d2.user_id
from documents d2
join users u on d2.user_id = u.id 
where d2.is_confirmed = 1
group by user_id
order by count_activity_docs desc

-- Определить кто больше пользуется услугами портала (приобрел услуги) - мужчины или женщины?

select count(py.id) as cnt_payment, p.gender
from payment py
join users u on py.user_id = u.id
join profile p on u.id = p.user_id
group by p.gender

-- Узнать самого взрослого и самого юного пользователя системы и посчитать их возраст  

(select (year (current_date())-year(p.birthday_date)) as age, concat(u.firstname, ' ', u.lastname) as name
from profile p
join users u on p.user_id = u.id
order by age limit 1)
union 
(select 
(year (current_date())-year(p.birthday_date)) as age, concat(u.firstname, ' ', u.lastname) as name
from profile p
join users u on p.user_id = u.id
order by age desc limit 1)
order by age

-- узнать 5 самых популярных услуг портала

select s.name, sc.name, count(py.services_id) as popular
from services s 
join services_category sc on s.category_service_id = sc.id
join payment py on s.id = py.services_id
group by s.name
order by popular desc limit 5




