package model

import (
	"github.com/go-playground/validator/v10"
	"gopkg.in/yaml.v3"
	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	Name    string `validate:"required,alphanum" gorm:"unique"`
	Code    string `validate:"required"`
	Session Session
}

// String returns string representation of User.
func (u *User) String() string {
	out, _ := yaml.Marshal(u)
	return string(out)
}

// Validate validates User fields.
func (u *User) Validate() error {
	return validator.New().Struct(u)
}
