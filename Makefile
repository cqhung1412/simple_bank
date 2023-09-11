postgres:
	docker run --name postgres_container --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:alpine

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

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

install:
	go mod tidy

build:
	go build -v ./...

test:
	go test -v -cover ./...

server:
	go mod tidy && go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go --build_flags=--mod=mod github.com/cqhung1412/simple_bank/db/sqlc Store

dockerbuild:
	docker build -t simple_bank:latest .

dockerrun:
	docker run --name simplebank --network bank-network -p 8080:8080 -e GIN_MODE=release simple_bank

networkdocker:
	docker network create bank-network

.PHONY: postgres createdb dropdb stopdb rmdb psql migrateup migratedown migrateup1 migratedown1 sqlc build test server mock dockerbuild dockerrun networkdocker