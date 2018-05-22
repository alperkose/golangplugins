package main

import "github.com/alperkose/golangplugins/user"

type SimpleProvider struct{}

func (p *SimpleProvider) User() *user.User {
	return user.New("Ned Stark", "ned.stark@north.gov", []string{"Winterfell"})
}

func NewUserProvider() user.Provider {
	return &SimpleProvider{}
}

func main() {}
