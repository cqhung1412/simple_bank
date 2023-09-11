![](https://github.com/cqhung1412/simple_bank/actions/workflows/ci.yml/badge.svg)

## Reference

[TECH SCHOOL - Backend Master Class](https://dev.to/techschoolguru/backend-master-class-go-postgres-kubernetes-aws-3ol)

## Before deploy

### Steps

- Create an EKS cluster and node group with at least t3.small instance type (11 pods)
- Create a RDS Postgres instance with public access and the name `simple_bank`
- Create secret in AWS Secret Manager with the name `simple-bank` based on sample `app.env`
- Try deploy

### Current issues

- [ ] `[GIN] 2023/07/22 - 21:44:04 | 404 |         665ns |    172.31.0.233 | GET      "/.well-known/acme-challenge/Wu6NgoxPQBiimzHZcUyCS9VDEWmc5zgLuHKeN8zY1WI"`

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

### AWS NLB

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.1/deploy/static/provider/aws/deploy.yaml
```
