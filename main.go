package main

import (
	"fmt"
	"plugin"

	"github.com/alperkose/golangplugins/user"
)

func main() {
	p, err := plugin.Open("plugin.so")
	if err != nil {
		panic(err)
	}
	providerFunc, err := p.Lookup("NewUserProvider")
	if err != nil {
		panic(err)
	}

	provider := providerFunc.(func() user.Provider)()

	user := provider.User()

	fmt.Println("Name:", user.Name())
	fmt.Println("Email", user.Email())

}
