table "accounts" {
    schema = schema.public
    comment = "账户表"
    column "id" {
        type = bigserial
    }
    column "owner" {
        type = varchar(255)
        comment = "所有者"
    }
    column "balance" {
        type = bigint
        comment = "余额"
    }
    column "currency" {
        type = varchar(10)
        comment = "货币"
    }
    column "created_at" {
        type = timestamptz
        default = sql("now()")
        comment = "创建时间"
    }
    primary_key {
        columns = [ column.id ]
    }
    index {
        columns = [column.owner]
    }
}
