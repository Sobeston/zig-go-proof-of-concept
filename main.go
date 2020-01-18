package main

import (
	"C"

	"github.com/nishanths/go-xkcd"
)

//export GetXKCD
func GetXKCD(number int) (*C.char, *C.char, bool) {
	client := xkcd.NewClient()
	comic, err := client.Get(number)
	if err != nil {
		return C.CString(""), C.CString(""), false
	}
	return C.CString(comic.Title), C.CString(comic.ImageURL), true
}

func main() {}
