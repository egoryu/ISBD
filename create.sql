create table "country"
(
    id          serial PRIMARY KEY,
    name        varchar(50) NOT NULL,
    description varchar(200)
);

create table "company"
(
    id          serial PRIMARY KEY,
    name        varchar(50) NOT NULL,
    description varchar(200)
);

create table "country_company"
(
    company_id int NOT NULL REFERENCES "company"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    country_id int NOT NULL REFERENCES "country"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table "user"
(
    id                serial      PRIMARY KEY,
    full_name         varchar(80) NOT NULL,
    age               smallint    NOT NULL CHECK (age >= 0),
    login             varchar(20) NOT NULL,
    email             varchar(50) NOT NULL,
    password          varchar(64) NOT NULL,
    salt              varchar(12) NOT NULL,
    registration_date timestamp   NOT NULL,
    country_id        int         NOT NULL REFERENCES "country"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table "ticket"
(
    id      serial      PRIMARY KEY,
    user_id int         NOT NULL REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    title   varchar(50) NOT NULL,
    content text
);

create table "currency"
(
    id         serial      PRIMARY KEY,
    name       varchar(50) NOT NULL,
    code       smallint    NOT NULL    CHECK (code >= 0),
    short_name varchar(5)  NOT NULL
);

create table "portfolio"
(
    id            serial      PRIMARY KEY,
    user_id       int         NOT NULL REFERENCES "user"(id)     ON DELETE CASCADE ON UPDATE CASCADE,
    currency_id   int         NOT NULL REFERENCES "currency"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name          varchar(50) NOT NULL,
    creation_date timestamp   NOT NULL
);

create table "stock category"
(
    id                       serial      PRIMARY KEY,
    name                     varchar(50) NOT NULL,
    stock_category_parent_id int         REFERENCES "stock category"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table "stock"
(
    id          serial      PRIMARY KEY,
    name        varchar(50) NOT NULL,
    description varchar(200),
    category_id int         NOT NULL REFERENCES "stock category"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    currency_id int         NOT NULL REFERENCES "currency"(id)       ON DELETE CASCADE ON UPDATE CASCADE
);

create table "trading history"
(
    id        serial    PRIMARY KEY,
    user_id   int       NOT NULL REFERENCES "user"(id)  ON DELETE CASCADE ON UPDATE CASCADE,
    stock_id  int       NOT NULL REFERENCES "stock"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    sell_time timestamp NOT NULL,
    amount    int       NOT NULL CHECK (amount > 0),
    price     int       NOT NULL CHECK (price > 0),
    type      smallint  NOT NULL DEFAULT 0
);

create table "portfolio item"
(
    id           serial PRIMARY KEY,
    portfolio_id int    NOT NULL REFERENCES "portfolio"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    stock_id     int    NOT NULL REFERENCES "stock"(id)     ON DELETE CASCADE ON UPDATE CASCADE,
    amount       int    NOT NULL CHECK (amount > 0)
);

create table "trading signal"
(
    id          serial    PRIMARY KEY,
    stock_id    int       NOT NULL REFERENCES "stock"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    signal_time timestamp NOT NULL,
    price       int       NOT NULL CHECK (price > 0),
    type        smallint  NOT NULL DEFAULT 0
);

create table "stock price"
(
    id       serial    PRIMARY KEY,
    stock_id int       NOT NULL REFERENCES "stock"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    date     timestamp NOT NULL,
    price    int       NOT NULL CHECK (price > 0)
);

create table "stock predication"
(
    id            serial    PRIMARY KEY,
    stock_id      int       NOT NULL REFERENCES "stock"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    date          timestamp NOT NULL,
    predict_price int       NOT NULL CHECK (predict_price > 0)
);

create table "stock category property"
(
    id                serial       PRIMARY KEY,
    stock_category_id int          NOT NULL REFERENCES "stock category"(id),
    name              varchar(50)  NOT NULL,
    is_required       smallint     DEFAULT 0,
    description       varchar(200)
);

create table "stock property value"
(
    id                         serial PRIMARY KEY,
    stock_category_property_id int    NOT NULL REFERENCES "stock category property"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    stock_id                   int    NOT NULL REFERENCES "stock"(id)                   ON DELETE CASCADE ON UPDATE CASCADE,
    value                      text   NOT NULL
);