--Процедура для добавления нового пользователя:
CREATE OR REPLACE PROCEDURE add_user(new_full_name varchar(80), new_login VARCHAR(50), new_age INT,
                                     new_email varchar(50), new_password varchar(64), new_salt varchar(12),
                                     new_country_id int)
AS $$
BEGIN
    INSERT INTO "user" (full_name, login, age, email, password, salt, registration_date, country_id)
    VALUES (new_full_name, new_login, new_age, new_email, new_password, new_salt, NOW(), new_country_id);
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
CREATE OR REPLACE PROCEDURE add_stock_prediction(stocked_id INT, predicted_price DECIMAL, prediction_date DATE)
AS $$
BEGIN
    INSERT INTO "stock_predication" (stock_id, predict_price, date)
    VALUES (stocked_id, predicted_price, prediction_date);
END;
$$ LANGUAGE plpgsql;

--Процедура для добавления новой категории акций:
CREATE OR REPLACE PROCEDURE add_stock_category(category_name VARCHAR(50), parent_category_id INT DEFAULT NULL)
AS $$
BEGIN
    INSERT INTO "stock_category" (name, stock_category_parent_id)
    VALUES (category_name, parent_category_id);
END;
$$ LANGUAGE plpgsql;