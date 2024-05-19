NAME=

migrations_gen:
ifeq ($(strip $(NAME)),)
	$(error "missing migrate name")
else
	atlas migrate diff $(NAME) \
		--dir "file://db/migrations" \
		--to "file://db/hcl" \
		--dev-url "docker://postgres/16-alpine" \
		--format '{{ sql . "  " }}'
endif

migrate_local:
	atlas schema apply \
  		--url "postgres://localhost:5432/simple_bank?sslmode=disable" \
 		--to "file://db/migrations" \
  		--dev-url "docker://postgres"

sqlc:
	sqlc generate

postgres_init:
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine

postgres:
	docker start postgres16

createdb:
	docker exec -it postgres16 createdb --username=root --owner=root simple_bank

.PHONY: migrations_gen migrate_local sqlc postgres_init postgres createdb
