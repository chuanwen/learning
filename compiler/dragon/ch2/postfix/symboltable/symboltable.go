package symboltable

const testVersion = 2

// Symbol contains type information.
type Symbol struct {
	Type string
}

func (sym Symbol) String() string {
	return sym.Type
}

// SymbolTable - (scoped) symbol table for identifier
type SymbolTable struct {
	table  map[string]Symbol
	parent *SymbolTable
}

// NewSymbolTable creates a new symbol table given parent table.
func NewSymbolTable(p *SymbolTable) SymbolTable {
	return SymbolTable{table: make(map[string]Symbol), parent: p}
}

// Put adds (name, symbol) to the table
func (st *SymbolTable) Put(name string, symbol Symbol) {
	st.table[name] = symbol
}

// Get looks up the entry for the identifier by searching the chain of tables.
func (st *SymbolTable) Get(name string) (Symbol, bool) {
	for cur := st; cur != nil; cur = cur.parent {
		if symbol, ok := cur.table[name]; ok {
			return symbol, true
		}
	}
	return Symbol{}, false
}
