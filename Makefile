NAME=
ENV=local

migrations_gen:
ifeq ($(strip $(NAME)),)
	$(error "missing migrate name")
else
	atlas migrate diff $(NAME) --env $(ENV)
endif

migrations_hash:
	atlas migrate hash --env $(ENV)

migrate:
	atlas migrate apply --env $(ENV)

sqlc:
	sqlc generate

postgres_init:
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine

postgres:
	docker start postgres16

createdb:
	docker exec -it postgres16 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres16 dropdb simple_bank

.PHONY: migrations_gen migrate sqlc postgres_init postgres createdb dropdb migrations_hash
