-- ��������� ����� ������ ������������ ������������ < 10 ���, �� ��������, ���� ���� media_id
-- ������� ������ 1 ����

select user_id, count(id) from media
where user_id in 
(select user_id from profiles where timestampdiff(year, birthday, now()) <10)
and id in 
(select media_id from likes)
group by user_id


-- ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..

select count(*) from likes
where media_id in 
(select id from media where user_id in 
(select user_id from profiles where timestampdiff(year, birthday, now()) <10))

-- ����� ����� ��������� ������������. �� ���� ������ ����� ������������ 
-- ������� ��������, ������� ������ ���� ������� � ����� �������������.

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


-- ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

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

select count(user_id) 
from likes
where user_id in
(select user_id from media where user_id in
(select user_id from profiles where gender = 'w'))