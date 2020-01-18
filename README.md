# zig-go-proof-of-concept
Cgo required, windows x64.

Build steps:     
`go build -buildmode=c-shared -ldflags="-s -w" -o main.dll main.go`     
`zig build-exe .\main.zig.`

