-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

select count(*) from likes
where media_id in 
(select id from media where user_id in 
(select user_id from profiles where timestampdiff(year, birthday, now()) <10))

-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя 
-- найдите человека, который больше всех общался с нашим пользователем.

select count(*), from_user_id, to_user_id from messages
where from_user_id = 1 and to_user_id in
(select id from users
where id in (select initiator_user_id from friend_requests where
(target_user_id = 1 and status = 'approved'))
union 
(select target_user_id from friend_requests where
(initiator_user_id = 1 and status = 'approved')))
or to_user_id =1 and from_user_id in
(select id from users
where id in (select initiator_user_id from friend_requests where
(target_user_id = 1 and status = 'approved'))
union 
(select target_user_id from friend_requests where
(initiator_user_id = 1 and status = 'approved')))
group by from_user_id, to_user_id
order by count(*) desc
