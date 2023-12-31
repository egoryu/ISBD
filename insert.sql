INSERT INTO "country" (id, name, description)
VALUES
    (1, 'Russia', 'Use Ruble'),
    (2, 'USA', 'Use Dollar'),
    (3, 'UK', 'Use Pound'),
    (4, 'Germany', 'Use Euro');

INSERT INTO "company" (id, name, description)
VALUES
    (1, 'VK', 'Social network'),
    (2, 'Yandex', 'Browser'),
    (3, 'Tinkoff', 'Bank'),
    (4, 'Ozon', 'Market');

INSERT INTO "country_company" (company_id, country_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1);

INSERT INTO "user" (id, full_name, age, login, email, password, salt, registration_date, country_id)
VALUES
    (1, 'Nikitin Egor', 20, 'egoryu', 'kek@gmail.com', 'Kek2', 'kek3', '2023-10-17 19:44:00', 1),
    (2, 'Misha Kek', 20, 'hunter', 'keker@gmail.com', 'kekker2', 'kek', '2023-10-17 19:46:00', 4);

INSERT INTO "ticket" (id, user_id, title, content)
VALUES
    (1, 1, 'Well done', 'Nothing');

INSERT INTO "currency" (id, name, code, short_name)
VALUES
    (1, 'Ruble', 643, 'RUB'),
    (2, 'Dollar', 840, 'USD'),
    (3, 'Euro', 978, 'EUR'),
    (4, 'Pound', 826, 'GBP');

INSERT INTO "portfolio" (id, user_id, currency_id, name, creation_date)
VALUES
    (1, 1, 1, 'First', '2023-10-17 19:56:00');

INSERT INTO "stock_category" (id, name, stock_category_parent_id)
VALUES
    (1, 'root', NULL),
    (2, 'shares', 1),
    (3, 'russian market', 2),
    (4, 'IT sector', 3);

INSERT INTO "stock" (id, name, description, category_id, currency_id)
VALUES
    (1, 'TCS Group', 'Tinkoff shares', 4, 1);

INSERT INTO "stock_price" (id, stock_id, date, price)
VALUES
    (1, 1, '2023-10-17 20:25:00', 352200),
    (2, 1, '2023-10-17 20:26:00', 352250);

INSERT INTO "stock_predication" (id, stock_id, date, predict_price)
VALUES
    (1, 1, '2023-10-17 20:25:00', 352200);

INSERT INTO "trading_history" (id, user_id, stock_id, sell_time, amount, price, type)
VALUES
    (1, 1, 1, '2023-10-17 20:25:00', 20, 352200, 0),
    (2, 1, 1, '2023-10-17 20:25:00', 10, 352260, 1);

INSERT INTO "portfolio_item" (id, portfolio_id, stock_id, amount)
VALUES
    (1, 1, 1, 100);

INSERT INTO "trading_signal" (id, stock_id, signal_time, price, type)
VALUES
    (1, 1, '2023-10-17 20:25:00', 352200, 1);

INSERT INTO "stock_category_property" (id, stock_category_id, name, is_required, description)
VALUES
    (1, 2, 'year', 1, 'year of incorporation'),
    (2, 2, 'capitalization', 1, 'company capitalization');

INSERT INTO "stock_property_value" (id, stock_category_property_id, stock_id, value)
VALUES
    (1, 1, 1, '2000'),
    (5, 2, 1, '137,317,438,844');
