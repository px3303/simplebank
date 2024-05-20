-- Modify "entries" table
ALTER TABLE "public"."entries" DROP CONSTRAINT "entries_account_id_fkey", ADD
 CONSTRAINT "entries_account_id_fk" FOREIGN KEY ("account_id") REFERENCES "public"."accounts" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION;
-- Modify "transfers" table
ALTER TABLE "public"."transfers" DROP CONSTRAINT "transfers_from_account_id_fkey", DROP CONSTRAINT "transfers_to_account_id_fkey", ADD
 CONSTRAINT "transfers_from_account_id_fk" FOREIGN KEY ("from_account_id") REFERENCES "public"."accounts" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, ADD
 CONSTRAINT "transfers_to_account_id_fk" FOREIGN KEY ("to_account_id") REFERENCES "public"."accounts" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION;
