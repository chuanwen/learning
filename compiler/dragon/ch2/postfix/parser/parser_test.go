package parser

import "testing"

var testCases = []struct {
	infix       string
	expected    string
	description string
}{
	{"10 + 2 // add two numbers", "10 2 +", "simple +"},
	{"x2/2.5", "x2 2.5 /", "simple variable"},
	{"9+5-2", "9 5 + 2 -", "two operators: + and -"},
	{"1+3/2", "1 3 2 / +", "two operators: + and /"},
	{"(3-2)*6", "3 2 - 6 *", "two ops with parenthesis"},
	{"0.9+(5-time1)*32.3", "0.9 5 time1 - 32.3 * +", "three ops with parenthesis"},
	{"(4-2)*(5+1)", "4 2 - 5 1 + *", "two parenthesis"},
	{"(5*(4-2)/6+3)*9", "5 4 2 - * 6 / 3 + 9 *", "nested parenthesis"},
}

const targetTestVersion = 2

func TestInfixToPostfix(t *testing.T) {
	if testVersion != targetTestVersion {
		t.Fatalf("Found testVersion = %v, want %v", testVersion, targetTestVersion)
	}
	for _, test := range testCases {
		observed := InfixToPostfix(test.infix)
		if observed != test.expected {
			t.Fatalf("InfixToPostfix(%s) = %s, want %s (%s)",
				test.infix, observed, test.expected, test.description)
		}
	}
}
