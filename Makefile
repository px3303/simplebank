.PHONY:

NAME=

migrations_gen:
ifeq ($(strip $(NAME)),)
	$(error "missing migrate name")
else
	@atlas migrate diff $(NAME) \
		--dir "file://db/migrations" \
		--to "file://db/hcl" \
		--dev-url "docker://postgres" \
		--format '{{ sql . "  " }}'
endif

migrate_local:
	@atlas schema apply \
  		--url "postgres://localhost:5432/simple_bank?sslmode=disable" \
 		--to "file://db/migrations" \
  		--dev-url "docker://postgres"

sqlc:
	@sqlc generate
