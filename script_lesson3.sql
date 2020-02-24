select distinct firstname from users;

update profiles
set is_active = false
where birthday > '2002-01-31';

delete from messages
where created_at > '2020-01-31';