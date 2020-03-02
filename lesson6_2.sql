-- Попытался найти самого залайконного пользователя, не работает, если 
-- у поста больше 1 лайка.

select user_id, count(id) from media
where user_id in 
(select user_id from profiles where timestampdiff(year, birthday, now()) <10)
and id in 
(select media_id from likes)
group by user_id


-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

select count(*) from likes
where media_id in 
(select id from media where user_id in 
(select user_id from profiles where timestampdiff(year, birthday, now()) <10))

-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, 
-- который больше всех общался с нашим пользователем.

select
	m.from_user_id,
	concat(u.firstname, ' ', u.lastname) as owner,
	count(*)
from messages m
join users u on from_user_id = u.id
where to_user_id = 1
group by m.from_user_id
order by count(*) desc
limit 1;


-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

select if 
((select count(user_id) 
from likes
where user_id in
(select user_id from media where user_id in
(select user_id from profiles where gender = 'm'))
>
(select count(user_id) 
from likes
where user_id in 
(select user_id from media where user_id in
(select user_id from profiles where gender = 'w')))),'women', 'men') as resultat;