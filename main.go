package main

import (
	"flag"
	"fmt"
	"plugin"

	"github.com/alperkose/golangplugins/user"
)

func main() {
	pluginFileName := flag.String("plugin", "simpleuser.plugin", "provide the plugin file name")
	flag.Parse()

	p, err := plugin.Open(*pluginFileName)
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
