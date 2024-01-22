package memory

type Code uint32

const (
	Internal Code = iota
	ErrNotFound
	AlreadyExists
)

type Error struct {
	Code    Code
	Message string
}

func (s Error) Error() string {
	return s.Message
}

func NewError(code Code, msg string) Error {
	return Error{
		Code:    code,
		Message: msg,
	}
}
