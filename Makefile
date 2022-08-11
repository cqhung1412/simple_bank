postgres:
	docker run --name postgres_container -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:alpine

createdb:
	docker exec -it postgres_container createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres_container dropdb simple_bank

stopdb: 
	docker stop postgres_container

rmdb:
	docker rm postgres_container

psql:
	docker exec -ti postgres_container psql -U root -d simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

build:
	go build -v ./...

test:
	go mod tidy && go test -v -cover ./...

server:
	go mod tidy && go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/cqhung1412/simple_bank/db/sqlc Store

.PHONY: postgres createdb dropdb stopdb rmdb psql migrateup migratedown sqlc build test server mock