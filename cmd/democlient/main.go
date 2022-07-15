package main

import (
	"github.com/gin-gonic/gin"
	"github.com/sinchop/smpp/client"
	"github.com/sinchop/smpp/message"
	"net/http"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	serverAddr := os.Getenv("SERVER_ADDR")
	serverPort := os.Getenv("SERVER_PORT")
	client := client.NewClient(serverAddr+":"+serverPort, "client", "pw")

	bindAttempts := 0

	for bindAttempts < 10 {
		client.Bind()
	}

	router := gin.Default()

	router.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"Status": "OK",
		})
	})

	router.GET("/submit", func(c *gin.Context) {
		text := c.Param("text")
		orig := c.Param("orig")
		dest := c.Param("dest")

		submitSmResp, err := client.SendSubmitSM(&message.ShortMessage{
			Src:        orig,
			Dst:        dest,
			Text:       []byte(text),
			DataCoding: message.DefaultType,
		})

		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error": err.Error(),
			})
			return
		}

		c.JSON(http.StatusOK, gin.H{
			"messageId": submitSmResp.MessageID,
		})
	})
	router.Run()

	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)
	<-sigs

}
