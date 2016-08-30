package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

var puts = fmt.Print
var lookahead string

func main() {
	for {
		lookahead = getToken()
		expr()
		puts("\n")
	}
}

func getToken() string {
	buf := make([]byte, 1)
	os.Stdin.Read(buf)
	return string(buf[0])
}

func expr() {
	term()
	rest()
}

func rest() {
	switch lookahead {
	case "+":
		match("+")
		term()
		puts("+")
		rest()
	case "-":
		match("-")
		term()
		puts("-")
		rest()
	}
}

func term() {
	if isDigit(lookahead) {
		t := lookahead
		match(lookahead)
		puts(t)
	}
}

func isDigit(x string) bool {
	i, err := strconv.Atoi(x)
	if err == nil && i >= 0 && i <= 9 {
		return true
	}
	return false
}

func match(x string) {
	if lookahead != x {
		log.Fatalf("exepceted %s, got %s", x, lookahead)
	}
	lookahead = getToken()
}
