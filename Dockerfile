# Build stage
# Use alpine golang image for small size container
FROM golang:alpine AS builder
# Switch to work directory of /app
WORKDIR /app
# Copy all file excluding listed in .dockerignore
COPY . .
# Build go binary
RUN go build -o main main.go

# Run stage
FROM alpine
WORKDIR /app
# Copy result from builder stage
COPY --from=builder /app/main .
# Expose container port to local
EXPOSE 8080
# Run the command when starting container
CMD ["/app/main"]
