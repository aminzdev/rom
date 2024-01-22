package token

import (
	"RomA-T.Server/util"
	"github.com/stretchr/testify/require"
	"testing"
	"time"
)

func TestPaseto(t *testing.T) {
	maker, err := NewPaseto(util.RandomString(32))
	require.NoError(t, err)

	user := util.RandomString(6)
	duration := time.Minute

	createdAt := time.Now()
	expiredAt := time.Now().Add(duration)

	_token, err := maker.CreateToken(user, duration)
	require.NoError(t, err)
	require.NotEmpty(t, _token)

	payload, err := maker.VerifyToken(_token)
	require.NoError(t, err)
	require.NotEmpty(t, payload)

	require.NotZero(t, payload.ID)
	require.Equal(t, user, payload.User)
	require.WithinDuration(t, createdAt, payload.CreatedAt, time.Second)
	require.WithinDuration(t, expiredAt, payload.ExpiredAt, time.Second)
}
