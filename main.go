package main

import (
	"C"

	"github.com/nishanths/go-xkcd"
)

//export GetXKCD
func GetXKCD(number int) (*C.char, *C.char) {
	client := xkcd.NewClient()
	comic, err := client.Get(number)
	if err != nil {
		panic(err)
	}
	return C.CString(comic.Title), C.CString(comic.ImageURL)
}

func main() {}
