%token INTEGER VARIABLE FUNC
%left '+' '-'
%left '*' '/'

%{
    #include <stdio.h>
    #include <math.h>
    int yylex(void);
    void yyerror(char *);
    int symtable[26];
%}


%%

program:
        program statement '\n'
        |
        ;

statement:
        expr                    { printf("%d\n", $1); }
        | VARIABLE '=' expr     { symtable[$1] = $3; }
expr:
        INTEGER               { $$ = $1; }
        | VARIABLE            { $$ = symtable[$1]; }
        | expr '+' expr       { $$ = $1 + $3; }
        | expr '-' expr       { $$ = $1 - $3; }
        | expr '*' expr       { $$ = $1 * $3; }
        | expr '/' expr       { $$ = $1 / $3; }
        | '(' expr ')'        { $$ = $2; }
        | FUNC '(' expr ')'   { if ($1 == 0) {
                                    $$ = (int)sqrt((double)$3);
                                } else {
                                    $$ = $3;
                                }
                              }
        ;


%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
