package memory

import (
	"RomA-T.Server/log"
	"github.com/rs/zerolog"
	"gorm.io/gorm"
	"io"
	"time"
)

// Memory is hexas-core's memory embedding gorm.DB
type Memory struct {
	db  *gorm.DB
	log *log.MemoryLogger
}

// NewMemory makes a new *Memory based on the driver and migrates the models
func NewMemory(driver Driver, logger io.Writer, models ...interface{}) (*Memory, error) {
	db, err := driver.ConnectDB()
	if err != nil {
		return nil, err
	}

	m := &Memory{
		db: db,
		log: log.NewMemoryLogger(
			zerolog.New(
				zerolog.ConsoleWriter{Out: logger, TimeFormat: time.DateTime, NoColor: true},
			).With().Timestamp().Str("module", "memory").Logger(),
		),
	}
	err = m.db.AutoMigrate(models...)
	if err != nil {
		return nil, err
	}

	return m, nil
}
