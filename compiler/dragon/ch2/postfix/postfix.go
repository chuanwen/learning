// Package postfix is syntax-directed translator that maps infix
// arithmetic expressions into postfix expressions. This is Go
// version of the Java program in Figure 2.27 in p75 of the Dragon
// book + extension of two operators (*, /) and parenthesis, e.g. 2*(5-3)
package postfix

import (
	"bytes"
	"fmt"
	"log"
	"strconv"
	"strings"
)

const testVersion = 2

var (
	stdin     *strings.Reader
	stdout    *bytes.Buffer
	lookahead string
)

// InfixToPostfix converts an infix arithmetic expression to
// a postfix one.
func InfixToPostfix(infix string) string {
	// initialize stdin and stdout
	stdin = strings.NewReader(infix)
	stdout = &bytes.Buffer{}

	lookahead = getToken()
	expr()

	return stdout.String()
}

func getToken() string {
	buf := make([]byte, 1)
	stdin.Read(buf)
	return string(buf[0])
}

func puts(args ...interface{}) {
	fmt.Fprint(stdout, args...)
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
