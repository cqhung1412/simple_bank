![](https://github.com/cqhung1412/simple_bank/actions/workflows/ci.yml/badge.svg)

## Reference
[TECH SCHOOL - Backend Master Class](https://dev.to/techschoolguru/backend-master-class-go-postgres-kubernetes-aws-3ol)

## Installing dependencies
### Golang-migrate
1. MacOS
```
brew install golang-migrate
```
2. Ubuntu
```
curl -s https://packagecloud.io/install/repositories/golang-migrate/migrate/script.deb.sh | sudo bash
sudo apt-get install migrate
```

### Sqlc
1. MacOS
```
brew install kyleconroy/sqlc/sqlc
```
2. Ubuntu
```
sudo snap install sqlc
```
3. Docker
```
docker pull kjconroy/sqlc
docker run --rm -v $(pwd):/src -w /src kjconroy/sqlc generate
```

### Mockgen
```
go install github.com/golang/mock/mockgen@v1.6.0
```
