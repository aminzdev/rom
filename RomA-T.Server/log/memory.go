package log

import (
	"github.com/rs/zerolog"
)

type Model string

const (
	userModel    Model = "user"
	sessionModel Model = "session"
)

type MemoryLogger struct {
	logger zerolog.Logger
}

func (l *MemoryLogger) Error(err error, reqID string) {
	l.logger.Error().Str("req.id", reqID).Err(err)
}

func NewMemoryLogger(logger zerolog.Logger) *MemoryLogger {
	return &MemoryLogger{logger: logger}
}
