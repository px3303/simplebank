schema "public" {}

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
  index "accounts_owner_idx" {
      columns = [column.owner]
  }
}

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
  foreign_key "entries_account_id_fk" {
      columns     = [column.account_id]
      ref_columns = [table.accounts.column.id]
  }
  index "entries_account_id_idx" {
      columns = [column.account_id]
  }
}

table "transfers" {
    schema = schema.public
    comment = "交易记录"
    column "id" {
        type = bigserial
    }
    column "from_account_id" {
        type = bigint
        comment = "来源账户ID"
    }
    column "to_account_id" {
        type = bigint
        comment = "目标账户ID"
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
    foreign_key "transfers_from_account_id_fk" {
        columns     = [column.from_account_id]
        ref_columns = [table.accounts.column.id]
    }
    foreign_key "transfers_to_account_id_fk" {
        columns     = [column.to_account_id]
        ref_columns = [table.accounts.column.id]
    }
    index "transfers_from_account_id_to_account_id_idx" {
        columns = [column.from_account_id, column.to_account_id]
    }
    index "transfers_to_account_id_idx" {
        columns = [column.to_account_id]
    }
}

