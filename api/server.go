package api

import (
	"fmt"
	"net/http"

	db "github.com/cqhung1412/simple_bank/db/sqlc"
	"github.com/cqhung1412/simple_bank/token"
	"github.com/cqhung1412/simple_bank/util"
	"github.com/gin-gonic/gin"
	"github.com/gin-gonic/gin/binding"
	"github.com/go-playground/validator/v10"
)

type Server struct {
	config     util.Config
	store      db.Store
	tokenMaker token.Maker
	router     *gin.Engine
}

func (server *Server) setupRouter() {
	// Create context that listens for the interrupt signal from the OS.
	// _ctx, stop := signal.NotifyContext(
	// 	context.Background(),
	// 	syscall.SIGINT,
	// 	syscall.SIGTERM,
	// )
	// defer stop()

	router := gin.Default()
	authRoutes := router.Group("/").Use(authMiddleware(server.tokenMaker))

	router.GET("/", func(ctx *gin.Context) {
		// hello route
		ctx.JSON(http.StatusOK, gin.H{
			"hello": "world",
		})
	})
	router.POST("/user", server.createUser)
	router.POST("/users/login", server.loginUser)

	authRoutes.POST("/account", server.createAccount)
	authRoutes.GET("/accounts", server.listAccounts)
	authRoutes.GET("/accounts/:id", server.getAccount)
	authRoutes.DELETE("/accounts/:id", server.deleteAccount)

	authRoutes.POST("/transfer", server.createTransfer)

	// log.Fatal(autotls.RunWithContext(ctx, router, "api.bigcitybear.info"))

	server.router = router
}

func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	// tokenMaker, err := token.NewJWTMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}

	server := &Server{
		store:      store,
		tokenMaker: tokenMaker,
	}

	if v, ok := binding.Validator.Engine().(*validator.Validate); ok {
		v.RegisterValidation("currency", validateCurrency)
	}

	server.setupRouter()
	return server, nil
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}

func (server *Server) Start(address string) error {
	return server.router.Run(address)
}
