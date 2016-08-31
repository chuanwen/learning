// Syntax-directed translator that maps infix arithmetic expressions into
// postfix expressions. This is Go version of the Java program in Figure 2.27
// in p75 of the Dragon book + extension of two operators (*, /) and
// parenthesis, e.g. 2*(5-3)
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
	for {
		switch lookahead {
		case "+":
			match("+")
			term()
			puts("+")
		case "-":
			match("-")
			term()
			puts("-")
		default:
			return
		}
	}
}

func term() {
	factor()
	for {
		switch lookahead {
		case "*":
			match("*")
			factor()
			puts("*")
		case "/":
			match("/")
			factor()
			puts("/")
		default:
			return
		}
	}
}

func factor() {
	switch {
	case isDigit(lookahead):
		puts(lookahead)
		match(lookahead)
	case lookahead == "(":
		match("(")
		expr()
		match(")")
	default:
		log.Fatalf("expected factor, got %s", lookahead)
	}
}

func isDigit(x string) bool {
	i, err := strconv.Atoi(x)
	return err == nil && i >= 0 && i <= 9
}

func match(x string) {
	if lookahead != x {
		log.Fatalf("exepceted %s, got %s", x, lookahead)
	}
	lookahead = getToken()
}
