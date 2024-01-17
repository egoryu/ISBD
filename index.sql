CREATE INDEX ON "country_company" USING BTREE ("country_id", "company_id");

CREATE INDEX ON "trading_signal" USING HASH ("type");

CREATE INDEX ON "stock_property_value" USING BTREE("stock_category_property_id", "stock_id");

CREATE INDEX ON "stock_category_property" USING BTREE ("stock_category_id");

CREATE INDEX ON "stock" USING HASH ("currency_id");
