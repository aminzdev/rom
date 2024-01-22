package memory

import (
	"fmt"
	"github.com/go-playground/validator/v10"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"strings"
)

type Driver interface {
	ConnectDB() (*gorm.DB, error)
}

type Postgres struct {
	Host     string `validate:"required,hostname_port|tcp_addr"`
	User     string `validate:"required"`
	Pass     string `validate:"required"`
	DBName   string `validate:"required" mapstructure:"db-name"`
	SSL      string `validate:"required,oneof=disable allow prefer require verify-ca verify-full"`
	TimeZone string `validate:"omitempty,timezone" mapstructure:"time-zone"`
}

func (p *Postgres) ConnectDB() (*gorm.DB, error) {
	if err := validator.New().Struct(p); err != nil {
		return nil, err
	}

	return gorm.Open(postgres.Open(p.dsn()), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Silent),
	})
}

func (p *Postgres) dsn() string {
	host, port := splitHostPort(p.Host)
	return fmt.Sprintf(
		"host=%s user=%s password=%s dbname=%s port=%s sslmode=%s TimeZone=%s",
		host, p.User, p.Pass, p.DBName, port, p.SSL, p.TimeZone,
	)
}

func splitHostPort(hostPort string) (host, port string) {
	split := strings.Split(hostPort, ":")

	if len(hostPort) == 0 {
		host = "localhost"
	} else {
		host = split[0]
	}

	if len(hostPort) < 2 {
		port = "5432"
	} else {
		port = split[1]
	}

	return host, port
}
