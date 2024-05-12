-- Create "accounts" table
CREATE TABLE "public"."accounts" (
  "id" bigserial NOT NULL,
  "owner" character varying(255) NOT NULL,
  "balance" bigint NOT NULL,
  "currency" character varying(10) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY ("id")
);
-- Create index "accounts_owner_idx" to table: "accounts"
CREATE INDEX "accounts_owner_idx" ON "public"."accounts" ("owner");
-- Set comment to table: "accounts"
COMMENT ON TABLE "public"."accounts" IS '账户表';
-- Set comment to column: "owner" on table: "accounts"
COMMENT ON COLUMN "public"."accounts" ."owner" IS '所有者';
-- Set comment to column: "balance" on table: "accounts"
COMMENT ON COLUMN "public"."accounts" ."balance" IS '余额';
-- Set comment to column: "currency" on table: "accounts"
COMMENT ON COLUMN "public"."accounts" ."currency" IS '货币';
-- Set comment to column: "created_at" on table: "accounts"
COMMENT ON COLUMN "public"."accounts" ."created_at" IS '创建时间';
-- Create "entries" table
CREATE TABLE "public"."entries" (
  "id" bigserial NOT NULL,
  "account_id" bigint NOT NULL,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "entries_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "public"."accounts" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create index "entries_account_id_idx" to table: "entries"
CREATE INDEX "entries_account_id_idx" ON "public"."entries" ("account_id");
-- Set comment to table: "entries"
COMMENT ON TABLE "public"."entries" IS '余额明细';
-- Set comment to column: "account_id" on table: "entries"
COMMENT ON COLUMN "public"."entries" ."account_id" IS '账户ID';
-- Set comment to column: "amount" on table: "entries"
COMMENT ON COLUMN "public"."entries" ."amount" IS '变动金额，正代表入，负代表出';
-- Set comment to column: "created_at" on table: "entries"
COMMENT ON COLUMN "public"."entries" ."created_at" IS '创建时间';
-- Create "transfers" table
CREATE TABLE "public"."transfers" (
  "id" bigserial NOT NULL,
  "from_account_id" bigint NOT NULL,
  "to_account_id" bigint NOT NULL,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "transfers_from_account_id_fkey" FOREIGN KEY ("from_account_id") REFERENCES "public"."accounts" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "transfers_to_account_id_fkey" FOREIGN KEY ("to_account_id") REFERENCES "public"."accounts" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create index "transfers_from_account_id_to_account_id_idx" to table: "transfers"
CREATE INDEX "transfers_from_account_id_to_account_id_idx" ON "public"."transfers" ("from_account_id", "to_account_id");
-- Create index "transfers_to_account_id_idx" to table: "transfers"
CREATE INDEX "transfers_to_account_id_idx" ON "public"."transfers" ("to_account_id");
-- Set comment to table: "transfers"
COMMENT ON TABLE "public"."transfers" IS '交易记录';
-- Set comment to column: "from_account_id" on table: "transfers"
COMMENT ON COLUMN "public"."transfers" ."from_account_id" IS '出金账户ID';
-- Set comment to column: "to_account_id" on table: "transfers"
COMMENT ON COLUMN "public"."transfers" ."to_account_id" IS '入金账户ID';
-- Set comment to column: "amount" on table: "transfers"
COMMENT ON COLUMN "public"."transfers" ."amount" IS '交易金额';
-- Set comment to column: "created_at" on table: "transfers"
COMMENT ON COLUMN "public"."transfers" ."created_at" IS '创建时间';
