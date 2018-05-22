package user

type User struct {
	name   string
	email  string
	access []string
}

func New(name, email string, access []string) *User {
	return &User{name, email, access}
}

func (u *User) Name() string {
	return u.name
}

func (u *User) Email() string {
	return u.email
}
func (u *User) Access() []string {
	return u.access
}
