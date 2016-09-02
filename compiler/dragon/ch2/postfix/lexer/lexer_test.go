package lexer

import (
	"reflect"
	"testing"
)

var isEq = reflect.DeepEqual

var testCases = []struct {
	input       string
	expected    []Token
	description string
}{
	{" varX1 *", []Token{{ID, "varX1"}, {OP, "*"}}, "variable and an operator"},
	{"10.5 + _time", []Token{{NUM, 10.5}, {OP, "+"}, {ID, "_time"}}, "arithmetic expression"},
	{"xyz == 25", []Token{{ID, "xyz"}, {OP, "=="}, {NUM, 25.0}}, "logical expression"},
	{"if (true) { x++ }",
		[]Token{
			{ID, "if"}, {int('('), nil}, {BOOL, true}, {int(')'), nil},
			{int('{'), nil}, {ID, "x"}, {OP, "++"}, {int('}'), nil}},
		"if statement"},
}

const targetTestVersion = 2

func TestScan(t *testing.T) {
	if testVersion != targetTestVersion {
		t.Fatalf("Found testVersion = %v, want %v", testVersion, targetTestVersion)
	}
	for _, test := range testCases {
		lexer := NewLexerForString(test.input)
		observed := make([]Token, 0, len(test.expected))
		for lexer.Scan() {
			observed = append(observed, lexer.Token())
		}
		if !isEq(observed, test.expected) {
			t.Fatalf("Input %s, got %v, want %v (%s)",
				test.input, observed, test.expected, test.description)
		}
	}
}
