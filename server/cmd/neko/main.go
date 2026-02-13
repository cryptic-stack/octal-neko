package main

import (
	"fmt"

	"github.com/rs/zerolog/log"

	neko "github.com/cryptic-stack/octal-neko/server"
	"github.com/cryptic-stack/octal-neko/server/cmd"
	"github.com/cryptic-stack/octal-neko/server/pkg/utils"
)

func main() {
	fmt.Print(utils.Colorf(neko.Header, "server", neko.Version))
	if err := cmd.Execute(); err != nil {
		log.Panic().Err(err).Msg("failed to execute command")
	}
}
