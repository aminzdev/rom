package auth

import (
	"RomA-T.Server/auth/token"
	"RomA-T.Server/log"
	"RomA-T.Server/memory"
	"github.com/rs/zerolog"
	"io"
	"time"
)

type Auth struct {
	memory     *memory.Memory
	log        *log.AuthLogger
	tokenMaker token.Maker
}

func NewAuth(m *memory.Memory, logger io.Writer, tokenMaker token.Maker) *Auth {
	return &Auth{
		memory: m,
		log: log.NewAuthLogger(
			zerolog.New(
				zerolog.ConsoleWriter{Out: logger, TimeFormat: time.DateTime, NoColor: true},
			).With().Timestamp().Str("module", "authentication").Logger(),
		),
		tokenMaker: tokenMaker,
	}
}

func (a *Auth) VerifyToken(accessToken string) (*token.Payload, error) {
	payload, err := a.tokenMaker.VerifyToken(accessToken)
	if err != nil {
		return nil, err
	}
	return payload, nil
}

func VerifyToken(tokenMaker token.Maker, accessToken string) (*token.Payload, error) {
	payload, err := tokenMaker.VerifyToken(accessToken)
	if err != nil {
		return nil, err
	}
	return payload, nil
}
