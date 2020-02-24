/* 8.1 Создайте хранимую функцию hello(), которая будет возвращать приветствие,
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать 
фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
 */

delimiter //
drop function if exists hello//
create function hello()
returns varchar(255) deterministic
	begin
		set @h = hour(current_timestamp());
		if (@h between 6 and 12) then
			return 'Доброе утро';
		elseif (@h between 12 and 18) then
			return 'Добрый день';
		elseif (@h between 18 and 24) then
			return 'Добрый вечер';
		else 
			return 'Доброй ночи';
		end if;
	end//

/* 8.2 В таблице products есть два текстовых поля: name с названием товара и 
description с его описанием. Допустимо присутствие обоих полей или одно из них. 
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.
 */
	
delimiter //
drop trigger if exists null_data_insert//
create trigger null_data_insert before insert on products
for each row
begin
	if (isnull(new.name) and isnull(new.description)) then
		signal sqlstate '45000' set message_text = 'insert canceled, input both fields';
	end if;
end//

delimiter //
drop trigger if exists null_data_update//
create trigger null_data_update before update on products
for each row
begin
	if (isnull(old.name) and isnull(old.description)) then
		signal sqlstate '45000' set message_text = 'update canceled, input both fields';
	end if;
end//

/* 8.3 Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух 
предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
*/

delimiter //
drop function if exists  fibonachi//
create function fibonachi(quantity int)
returns int deterministic
begin
	declare fs double;
	set fs = sqrt(5); 
	
	return (pow((1 + fs) /2.0, quantity) + pow((1 - fs) / 2.0, quantity)) / fs;
end//
