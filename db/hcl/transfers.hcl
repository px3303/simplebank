table "transfers" {
    schema = schema.public
    comment = "交易记录"
    column "id" {
        type = bigserial
    }
    column "from_account_id" {
        type = bigint
        comment = "出金账户ID"
    }
    column "to_account_id" {
        type = bigint
        comment = "入金账户ID"
    }
    column "amount" {
        type = bigint
        comment = "交易金额"
    }
    column "created_at" {
        type = timestamptz
        default = sql("now()")
        comment = "创建时间"
    }
    primary_key {
        columns = [ column.id ]
    }
    foreign_key {
        columns     = [column.from_account_id]
        ref_columns = [table.accounts.column.id]
    }
    foreign_key {
        columns     = [column.to_account_id]
        ref_columns = [table.accounts.column.id]
    }
    index {
        columns = [column.from_account_id, column.to_account_id]
    }
    index {
        columns = [column.to_account_id]
    }
}
