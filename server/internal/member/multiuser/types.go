package multiuser

import "github.com/cryptic-stack/octal-neko/server/pkg/types"

type Config struct {
	AdminPassword string
	UserPassword  string
	AdminProfile  types.MemberProfile
	UserProfile   types.MemberProfile
}
