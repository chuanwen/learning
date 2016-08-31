package postfix

import "testing"

var testCases = []struct {
	infix       string
	expected    string
	description string
}{
	{"1+2", "12+", "simple +"},
	{"1/2", "12/", "simple /"},
	{"9+5-2", "95+2-", "two operators: + and -"},
	{"1+3/2", "132/+", "two operators: + and /"},
	{"(3-2)*6", "32-6*", "two ops with parenthesis"},
	{"9+(5-2)*3", "952-3*+", "three ops with parenthesis"},
	{"(4-2)*(5+1)", "42-51+*", "two parenthesis"},
	{"(5*(4-2)/6+3)*9", "542-*6/3+9*", "nested parenthesis"},
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
