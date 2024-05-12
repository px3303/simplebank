table "entries" {
    schema = schema.public
    comment = "余额明细"
    column "id" {
        type = bigserial
    }
    column "account_id" {
        type = bigint
        comment = "账户ID"
    }
    column "amount" {
        type = bigint
        comment = "变动金额，正代表入，负代表出"
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
        columns     = [column.account_id]
        ref_columns = [table.accounts.column.id]
    }
    index {
        columns = [column.account_id]
    }
}
