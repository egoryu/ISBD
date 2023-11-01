-- Триггер для проверки возраста пользователя
CREATE OR REPLACE FUNCTION check_user_age()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'User must be at least 18 years old';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_user_age_trigger
    BEFORE INSERT OR UPDATE ON "user"
                         FOR EACH ROW
                         EXECUTE FUNCTION check_user_age();


-- Триггер для проверки наличия акций в портфеле
CREATE OR REPLACE FUNCTION check_portfolio_item_amount()
RETURNS TRIGGER AS $$
DECLARE
total_amount INT;
BEGIN
SELECT SUM(amount) INTO total_amount
FROM "portfolio item"
WHERE portfolio_id = NEW.portfolio_id;

IF total_amount + NEW.amount > 100 THEN
        RAISE EXCEPTION 'Total amount of stocks in portfolio exceeds the limit of 100';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_portfolio_item_amount_trigger
    BEFORE INSERT OR UPDATE ON "portfolio item"
                         FOR EACH ROW
                         EXECUTE FUNCTION check_portfolio_item_amount();


-- Триггер для проверки наличия курса акции
CREATE OR REPLACE FUNCTION check_stock_price()
RETURNS TRIGGER AS $$
DECLARE
stock_count INT;
BEGIN
SELECT COUNT(*) INTO stock_count
FROM "stock price"
WHERE stock_id = NEW.stock_id;

IF stock_count = 0 THEN
        RAISE EXCEPTION 'Stock price not available';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_stock_price_trigger
    BEFORE INSERT OR UPDATE ON "trading history"
                         FOR EACH ROW
                         EXECUTE FUNCTION check_stock_price();

--Триггер для проверки уникальности логина пользователя
CREATE OR REPLACE FUNCTION check_user_login_unique()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "user"
        WHERE login = NEW.login
            AND id <> NEW.id
    ) THEN
        RAISE EXCEPTION 'Login already exists';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_user_login_unique_trigger
    BEFORE INSERT OR UPDATE ON "user"
                         FOR EACH ROW
                         EXECUTE FUNCTION check_user_login_unique();

--Триггер для автоматического обновления даты создания портфеля:
CREATE OR REPLACE FUNCTION update_portfolio_creation_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.creation_date = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_portfolio_creation_date_trigger
BEFORE INSERT ON "portfolio"
FOR EACH ROW
EXECUTE FUNCTION update_portfolio_creation_date();

--Триггер для проверки наличия родительской категории акций:
CREATE OR REPLACE FUNCTION check_stock_category_parent()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.stock_category_parent_id IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM "stock category"
            WHERE id = NEW.stock_category_parent_id
        ) THEN
            RAISE EXCEPTION 'Parent stock category does not exist';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_stock_category_parent_trigger
BEFORE INSERT OR UPDATE ON "stock category"
FOR EACH ROW
EXECUTE FUNCTION check_stock_category_parent();

--Триггер для проверки наличия записей о цене акции перед добавлением предсказаний:
CREATE OR REPLACE FUNCTION check_stock_price_existence()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM "stock price"
        WHERE stock_id = NEW.stock_id
    ) THEN
        RAISE EXCEPTION 'Stock price not available for prediction';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_stock_price_existence_trigger
BEFORE INSERT OR UPDATE ON "stock predication"
FOR EACH ROW
EXECUTE FUNCTION check_stock_price_existence();

--Триггер для проверки суммарной стоимости продажи акций в истории торговли:
CREATE OR REPLACE FUNCTION check_trading_history_total_price()
RETURNS TRIGGER AS $$
DECLARE
    total_price INT;
BEGIN
    SELECT SUM(amount * price) INTO total_price
    FROM "trading history"
    WHERE user_id = NEW.user_id;

    IF total_price + (NEW.amount * NEW.price) > 1000000 THEN
        RAISE EXCEPTION 'Total trading value exceeds the limit of 1,000,000';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_trading_history_total_price_trigger
BEFORE INSERT OR UPDATE ON "trading history"
FOR EACH ROW
EXECUTE FUNCTION check_trading_history_total_price();