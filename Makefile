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

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb stopdb rmdb psql migrateup migratedown sqlc test