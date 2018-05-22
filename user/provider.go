package user

type Provider interface {
	User() *User
}
