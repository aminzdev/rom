package auth

import (
	"fmt"
	"golang.org/x/crypto/bcrypt"
)

// HashCode returns the bcrypt hash of the code
func HashCode(code string) (string, error) {
	hashedCode, err := bcrypt.GenerateFromPassword([]byte(code), bcrypt.DefaultCost)
	if err != nil {
		return "", fmt.Errorf("failed to hash code: %w", err)
	}
	return string(hashedCode), nil
}

// CheckCode checks if the provided code is correct or not
func CheckCode(code string, hashedCode string) error {
	return bcrypt.CompareHashAndPassword([]byte(hashedCode), []byte(code))
}
