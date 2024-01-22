package auth

import (
	"RomA-T.Server/util"
	"github.com/stretchr/testify/require"
	"golang.org/x/crypto/bcrypt"
	"testing"
)

func TestHashCode(t *testing.T) {
	code := util.RandomString(6)

	hashedCode1, err := HashCode(code)
	require.NoError(t, err)
	require.NotEmpty(t, hashedCode1)

	err = CheckCode(code, hashedCode1)
	require.NoError(t, err)

	wrongCode := util.RandomString(6)
	err = CheckCode(wrongCode, hashedCode1)
	require.EqualError(t, err, bcrypt.ErrMismatchedHashAndPassword.Error())

	hashedCode2, err := HashCode(code)
	require.NoError(t, err)
	require.NotEmpty(t, hashedCode2)
	require.NotEqual(t, hashedCode1, hashedCode2)
}
