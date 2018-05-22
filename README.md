# go-plugins
Sandbox for testing golang plugins 

When plugin is being built, the imports of the plugin and the actual code that uses plugin should have the same import path.

When `vendor` feature of golang was used, the import path of any dependencies changes. And this causes an error while loading the plugin.

## Example without vendoring
`./run-with-simpleuser.sh` will run the `main.go` with simpleuser plugin without using vendor folder. The execution will run without any issue

## Example with vendoring
`./run-with-vendoreduser.sh` will run the main.go with vendoreduser plugin with vendoring support. It will copy the user package to its vendor folder first, build the plugin and run `main.go` with the built plugin file which will cause an error:
```
panic: interface conversion: plugin.Symbol is func() user.Provider, not func() user.Provider
```

Eventhough a similar issue was resolved in [this issue](http://golang.org/cl/63693) vendoring for plugins is not supported as of `go 1.10.2`


## Caveats
- plugins must be built with the same version of the Go toolchain as the main application
- your plugin needs to be built from a main package
    - `go build -o plugin.so -buildmode=plugin .`
- Before version 1.9.2; GOPATH for plugins and the actual system should be the same
- Even after version 1.9.2 code for the plugin and the actual system should not use vendor folders (at least for the common packages)

