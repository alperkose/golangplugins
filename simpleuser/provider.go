package main

import "github.com/alperkose/golangplugins/user"

type SimpleProvider struct{}

func (p *SimpleProvider) User() *user.User {
	return user.New("Jon Snow", "jon.snow@nightwatch.gov", []string{"Castle Black"})
}

func NewUserProvider() user.Provider {
	return &SimpleProvider{}
}

func main() {}
