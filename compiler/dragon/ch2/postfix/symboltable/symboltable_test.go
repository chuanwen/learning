package symboltable

import "testing"

const targetTestVersion = 2

func TestScan(t *testing.T) {
	if testVersion != targetTestVersion {
		t.Fatalf("Found testVersion = %v, want %v", testVersion, targetTestVersion)
	}
	// setup two chained symbol tables.
	parent := NewSymbolTable(nil)
	parent.Put("x", Symbol{"Int"})
	parent.Put("y", Symbol{"Double"})
	parent.Put("isInt", Symbol{"Function/1"})
	current := NewSymbolTable(&parent)
	current.Put("x", Symbol{"Bool"})
	current.Put("a", Symbol{"[]Double"})
	current.Put("max", Symbol{"Function/2"})

	var testCases = []struct {
		env         *SymbolTable
		identifier  string
		expected    string
		description string
	}{
		{&parent, "x", "Int", "global var"},
		{&parent, "y", "Double", "global var"},
		{&parent, "isInt", "Function/1", "global func"},
		{&parent, "a", "", "not global var"},
		{&parent, "max", "", "not global func"},
		{&current, "x", "Bool", "local shadow global var"},
		{&current, "y", "Double", "global var (no local shadow)"},
		{&current, "isInt", "Function/1", "global func"},
		{&current, "a", "[]Double", "local var"},
		{&current, "max", "Function/2", "local func"},
	}
	for _, test := range testCases {
		observed, _ := test.env.Get(test.identifier)
		if observed.String() != test.expected {
			t.Fatalf("Input %s, got %v, want %v (%s)",
				test.identifier, observed, test.expected, test.description)
		}
	}
}
