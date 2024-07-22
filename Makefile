.PHONY: createdb dropdb showdb postgres sqlc test
	
postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine

createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres dropdb simple_bank

showdb:
	docker exec -it postgres psql -U root simple_bank

test:
	go test -v -cover ./...

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose down

sqlc:
	docker run --rm -v "C:\Users\DELL\restapi_gprc":/src -w /src kjconroy/sqlc generate