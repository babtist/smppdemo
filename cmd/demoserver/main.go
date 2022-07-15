package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"github.com/google/uuid"
	"github.com/sinchop/smpp/message"
	"github.com/sinchop/smpp/server"
)

func main() {
	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	s := server.NewServer("test", 3601,
		func(c server.Conn, submit *message.ShortMessage) (*message.ShortMessageResp, error) {
			b, err := json.Marshal(submit)
			if err != nil {
				fmt.Println(err)
			} else {
				fmt.Println(string(b))
			}
			return &message.ShortMessageResp{
				MessageID: uuid.NewString(),
				Status:    message.Status_OK,
			}, nil
		})

	s.AddAccount(&server.Account{
		UserName: "client",
		Password: "pw",
	})

	s.Start()
	<-sigs
}
