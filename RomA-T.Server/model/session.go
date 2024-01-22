package model

import "gorm.io/gorm"

type Session struct {
	gorm.Model
	UserID int
	Token  string
}
