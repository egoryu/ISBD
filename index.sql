CREATE INDEX ON "user" USING HASH ("id");
CREATE INDEX ON "user" USING HASH ("age");
CREATE INDEX ON "user" USING BTREE ("registration_date");

CREATE INDEX ON "portfolio" USING HASH ("user_id");

CREATE INDEX ON "stock" USING HASH ("category_id");
CREATE INDEX ON "stock" USING HASH ("currency_id");

CREATE INDEX ON "portfolio_item" USING HASH ("portfolio_id");

CREATE INDEX ON "trading_signal" USING HASH ("stock_id");
CREATE INDEX ON "trading_signal" USING BTREE ("signal_time");

CREATE INDEX ON "stock_price" USING HASH ("stock_id");
CREATE INDEX ON "stock_price" USING BTREE ("date");

CREATE INDEX ON "stock_predication" USING HASH ("stock_id");
CREATE INDEX ON "stock_predication" USING BTREE ("date");
