--Функция для получения среднего значения цены акций по категории:
CREATE OR REPLACE FUNCTION get_average_stock_price_by_category(category_id INT)
RETURNS DECIMAL AS $$
DECLARE
    average_price DECIMAL;
BEGIN
    SELECT AVG(price) INTO average_price
    FROM "stock_price" sp
    INNER JOIN "stock" s ON sp.stock_id = s.id
    WHERE s.category_id = category_id;

    RETURN average_price;
END;
$$ LANGUAGE plpgsql;

--Функция для получения списка акций в портфеле пользователя:
CREATE OR REPLACE FUNCTION get_portfolio_stocks(user_id INT)
RETURNS TABLE (
    stock_id INT,
    stock_name VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY
    SELECT p.stock_id, s.name
    FROM "portfolio_item" p
    INNER JOIN "stock" s ON p.stock_id = s.id
    WHERE p.user_id = user_id;
END;
$$ LANGUAGE plpgsql;

--Функция для получения общей стоимости акций в портфеле пользователя:
CREATE OR REPLACE FUNCTION get_portfolio_total_value(user_id INT)
RETURNS DECIMAL AS $$
DECLARE
    total_value DECIMAL;
BEGIN
    SELECT SUM(p.amount * sp.price) INTO total_value
    FROM "portfolio_item" p
    INNER JOIN "stock_price" sp ON p.stock_id = sp.stock_id
    WHERE p.user_id = user_id;

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
    SELECT sp.stock_id, s.name, sp.predicted_price
    FROM "stock_prediction" sp
    INNER JOIN "stock" s ON sp.stock_id = s.id
    WHERE sp.prediction_date = prediction_date;
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