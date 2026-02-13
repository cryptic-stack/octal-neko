package object

import (
	"github.com/cryptic-stack/octal-neko/server/pkg/types"
)

type memberEntry struct {
	password string
	profile  types.MemberProfile
}

func (m *memberEntry) CheckPassword(password string) bool {
	return m.password == password
}

type User struct {
	Username string
	Password string
	Profile  types.MemberProfile
}

type Config struct {
	Users []User
}
