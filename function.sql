--Функция для получения среднего значения цены акций по категории:
CREATE OR REPLACE FUNCTION get_average_stock_price_by_category(categories_id INT)
RETURNS DECIMAL AS $$
DECLARE
    average_price DECIMAL;
BEGIN
    SELECT AVG(price) INTO average_price
    FROM "stock_price" sp
    INNER JOIN "stock" s ON sp.stock_id = s.id
    WHERE s.category_id = categories_id;

    RETURN average_price;
END;
$$ LANGUAGE plpgsql;

--Функция для получения списка акций в портфеле пользователя:
CREATE OR REPLACE FUNCTION get_portfolio_stocks(users_id INT)
RETURNS TABLE (
    stock_id INT,
    stock_name VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY
    SELECT pi.stock_id, s.name
    FROM "portfolio" p
    JOIN "portfolio_item" pi ON p.id = pi.portfolio_id
    JOIN "stock" s ON pi.stock_id = s.id
    WHERE p.user_id = users_id;
END;
$$ LANGUAGE plpgsql;

--Функция для получения общей стоимости акций в портфеле пользователя:
CREATE OR REPLACE FUNCTION get_portfolio_total_value(users_id INT)
RETURNS DECIMAL AS $$
DECLARE
    total_value DECIMAL;
BEGIN
    SELECT SUM(pi.amount * sp.price) INTO total_value
    FROM "portfolio" p
    JOIN "portfolio_item" pi ON p.id = pi.portfolio_id
    JOIN "stock_price" sp ON pi.stock_id = sp.stock_id
    WHERE p.user_id = users_id;

    RETURN total_value;
END;
$$ LANGUAGE plpgsql;

--Функция для получения списка предсказаний цены акции по дате:
CREATE OR REPLACE FUNCTION get_stock_predictions_by_date(prediction_date DATE)
RETURNS TABLE (
    stock_id INT,
    stock_name VARCHAR(50),
    predicted_price DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT sp.stock_id, s.name, sp.predict_price
    FROM "stock_predication" sp
    INNER JOIN "stock" s ON sp.stock_id = s.id
    WHERE sp.date = prediction_date;
END;
$$ LANGUAGE plpgsql;

--Функция для получения количества акций в портфеле пользователя:
CREATE OR REPLACE FUNCTION get_portfolio_stock_count(user_id INT)
RETURNS INT AS $$
DECLARE
    stock_count INT;
BEGIN
    SELECT COUNT(*) INTO stock_count
    FROM "portfolio_item"
    WHERE user_id = user_id;

    RETURN stock_count;
END;
$$ LANGUAGE plpgsql;