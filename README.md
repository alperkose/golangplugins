# go-plugins
Sandbox for testing golang plugins 

You can find more explanations here: https://medium.com/@alperkose/things-to-avoid-while-using-golang-plugins-f34c0a636e8

## Running examples:
Running `./run.sh` will build the plugins and the main application using docker. The base image for building and running are by default `golang:1.11`. But you may pass different versions as the first parameter: `./run.sh 1.10`

When you run the shell script you should see an output like:

    # Go version
    ------------
    go version go1.11.2 linux/amd64

    # Running with non-vendored implementation
    ------------------------------------------
    Name: Jon Snow
    Email jon.snow@nightwatch.org

    # Running with implementation in different gopath
    -------------------------------------------------
    panic: plugin.Open("differentgopath.plugin"): plugin was built with a different version of package github.com/alperkose/golangplugins/user

    goroutine 1 [running]:
    main.main()
            /go/src/github.com/alperkose/golangplugins/main.go:17 +0x3a4
    # Running with vendored implementation
    --------------------------------------
    panic: interface conversion: plugin.Symbol is func() user.Provider, not func() user.Provider (types from different scopes)

    goroutine 1 [running]:
    main.main()
            /go/src/github.com/alperkose/golangplugins/main.go:24 +0x384

## Plugin Caveats
- plugins must be built with the same version of the Go toolchain as the main application
- your plugin needs to be built from a main package
    - `go build -o plugin.so -buildmode=plugin .`
- GOPATH for plugins and the actual system should be the same
- Code for the plugin and the actual system should not use vendor folders (at least for the common packages)


