variable "url" {
    type    = string
    default = "postgres://root:secret@localhost:5432/simple_bank?sslmode=disable"
}

variable "dev" {
    type    = string
    default = "docker://postgres/16-alpine"
}

env {
    name = atlas.env

    url = var.url

    src = "file://db/hcl"

    dev = var.dev

    migration {
        dir = "file://db/migrations"
    }

    format {
        migrate {
            diff = "{{ sql . \" \" }}"
        }
    }
}
