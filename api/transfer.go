package api

import (
	"net/http"

	db "github.com/cqhung1412/simple_bank/db/sqlc"
	"github.com/gin-gonic/gin"
)

type putTransferRequest struct {
	FromAccountID int64 `json:"from_account_id" binding:"required,min=1"`
	ToAccountID   int64 `json:"to_account_id" binding:"required,min=1"`
	Amount        int64 `json:"amount" binding:"required,min=1"`
}

func (server *Server) putTransfer(ctx *gin.Context) {
	var req putTransferRequest
	if err := ctx.BindJSON(&req); err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}
	arg := db.TransferTxParams{
		FromAccountID:  req.FromAccountID,
		ToAccountID:    req.ToAccountID,
		TransferAmount: req.Amount,
	}

	result, err := server.store.TransferTx(ctx, arg)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, result)
}
