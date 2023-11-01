--Процедура для добавления нового пользователя:
CREATE OR REPLACE PROCEDURE add_user(login VARCHAR(50), age INT)
AS $$
BEGIN
    INSERT INTO "user" (login, age)
    VALUES (login, age);
END;
$$ LANGUAGE plpgsql;

--Процедура для обновления информации о пользователе:
CREATE OR REPLACE PROCEDURE update_user_info(user_id INT, new_login VARCHAR(50), new_age INT)
AS $$
BEGIN
    UPDATE "user"
    SET login = new_login, age = new_age
    WHERE id = user_id;
END;
$$ LANGUAGE plpgsql;

--Процедура для добавления нового предсказания цены акции:
CREATE OR REPLACE PROCEDURE add_stock_prediction(stock_id INT, predicted_price DECIMAL, prediction_date DATE)
AS $$
BEGIN
    INSERT INTO "stock prediction" (stock_id, predicted_price, prediction_date)
    VALUES (stock_id, predicted_price, prediction_date);
END;
$$ LANGUAGE plpgsql;

--Процедура для удаления пользователя и связанных с ним записей:
CREATE OR REPLACE PROCEDURE delete_user(user_id INT)
AS $$
BEGIN
    DELETE FROM "user" WHERE id = user_id;
    DELETE FROM "portfolio item" WHERE user_id = user_id;
    DELETE FROM "trading history" WHERE user_id = user_id;
END;
$$ LANGUAGE plpgsql;

--Процедура для добавления новой категории акций:
CREATE OR REPLACE PROCEDURE add_stock_category(category_name VARCHAR(50), parent_category_id INT DEFAULT NULL)
AS $$
BEGIN
    INSERT INTO "stock category" (name, parent_category_id)
    VALUES (category_name, parent_category_id);
END;
$$ LANGUAGE plpgsql;