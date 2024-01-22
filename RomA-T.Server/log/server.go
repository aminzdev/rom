package log

import (
	"github.com/rs/zerolog"
)

type ServerLogger struct {
	name   string
	logger zerolog.Logger
}

func (l *ServerLogger) Error(err error) {
	l.logger.Error().Err(err)
}

func (l *ServerLogger) Info(message string) {
	l.logger.Info().Msg(message)
}

func NewServerLogger(name string, logger zerolog.Logger) *ServerLogger {
	return &ServerLogger{name: name, logger: logger}
}
