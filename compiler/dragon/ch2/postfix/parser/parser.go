// Package parser is syntax-directed translator that maps infix
// arithmetic expressions into postfix expressions. This is Go
// version of the Java program in Figure 2.27 in p75 of the Dragon
// book + extension of two operators (*, /) and parenthesis, e.g. 2*(5-3)
package parser

import (
	"bytes"
	"fmt"
	"log"
	"strings"

	"../lexer"
)

const testVersion = 2

var (
	scanner   *lexer.Lexer
	stdout    *bytes.Buffer
	lookahead lexer.Token
)

// InfixToPostfix converts an infix arithmetic expression to
// a postfix one.
func InfixToPostfix(infix string) string {
	// initialize lexer and stdout
	scanner = lexer.NewLexerForString(infix)
	stdout = &bytes.Buffer{}

	lookahead = getToken()
	expr()

	return strings.TrimSpace(stdout.String())
}

func getToken() lexer.Token {
	if scanner.Scan() {
		return scanner.Token()
	}
	return lexer.Token{}
}

func puts(args ...interface{}) {
	fmt.Fprint(stdout, args...)
}

func expr() {
	term()
	for {
		switch lookahead.String() {
		case "+":
			match(lookahead)
			term()
			puts("+ ")
		case "-":
			match(lookahead)
			term()
			puts("- ")
		default:
			return
		}
	}
}

func term() {
	factor()
	for {
		switch lookahead.String() {
		case "*":
			match(lookahead)
			factor()
			puts("* ")
		case "/":
			match(lookahead)
			factor()
			puts("/ ")
		default:
			return
		}
	}
}

func factor() {
	switch {
	case lookahead.Tag == lexer.NUM || lookahead.Tag == lexer.ID:
		puts(lookahead.String(), " ")
		match(lookahead)
	case lookahead.String() == "(":
		match(lookahead)
		expr()
		match(lexer.Token{int(')'), nil})
	default:
		log.Fatalf("expected factor, got %s", lookahead)
	}
}

func match(x lexer.Token) {
	if lookahead != x {
		log.Fatalf("exepceted %s, got %s", x, lookahead)
	}
	lookahead = getToken()
}
