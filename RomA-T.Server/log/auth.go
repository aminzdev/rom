package log

import (
	"github.com/rs/zerolog"
)

type AuthLogger struct {
	logger zerolog.Logger
}

func (l *AuthLogger) Error(err error, reqID string) {
	l.logger.Error().Str("req.id", reqID).Err(err)
}

func (l *AuthLogger) UserNotFound(user, reqID string) {
	l.logger.Error().Str("req.id", reqID).Msgf("user '%s' not found", user)
}

func (l *AuthLogger) InvalidCode(user, reqID string) {
	l.logger.Error().Str("req.id", reqID).Msgf("user '%s' invalid code", user)
}

func (l *AuthLogger) FailedTokenCreation(user string, err error, reqID string) {
	l.logger.Error().Str("req.id", reqID).Msgf("could not create token for user '%s', %v", user, err)
}

func (l *AuthLogger) UserSessionUpdateFailed(user, reqID string) {
	l.logger.Error().Str("req.id", reqID).Msgf("could not update session for user '%s'", user)
}

func (l *AuthLogger) UserLoggedIn(user, reqID string) {
	l.logger.Info().Str("req.id", reqID).Msgf("user '%s' logged in", user)
}

func (l *AuthLogger) RoleAssignmentFailed(user, role, reqID string) {
	l.logger.Error().Str("req.id", reqID).Msgf("could not assign role '%s' to user '%s'", role, user)
}

func (l *AuthLogger) GettingRolesFailed(reqID string) {
	l.logger.Error().Str("req.id", reqID).Msg("could not get roles")
}

func (l *AuthLogger) GettingUserRolesFailed(user, reqID string) {
	l.logger.Error().Str("req.id", reqID).Msgf("could not get roles for user '%s'", user)
}

func (l *AuthLogger) UnauthorizedAccess(user, reqID string) {
	l.logger.Error().Str("req.id", reqID).Msgf("unauthorized access by user '%s'", user)
}

func NewAuthLogger(logger zerolog.Logger) *AuthLogger {
	return &AuthLogger{logger: logger}
}
