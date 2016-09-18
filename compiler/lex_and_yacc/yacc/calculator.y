%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "calculator.h"
#include <math.h>

/* prototypes */
nodeType *opr(int oper, int nops, ...);
nodeType *id(int i);
nodeType *con(double value);
void freeNode(nodeType *p);
int ex(nodeType *p);
int yylex(void);

void yyerror(char *);
double symtable[26];
%}

%union{
    double dValue;      /* double value */
    char sIndex;        /* symbol table index */
    nodeType *nPtr;     /* node pointer */
}

%token <dValue> DOUBLE 
%token <sIndex> VARIABLE
%token WHILE IF PRINT
%nonassoc IFX
%nonassoc ELSE INC1 DEC1


%left ADDE SUBE MULE DIVE
%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/' '%'
%left '^'
%nonassoc UMINUS

%type <nPtr> stmt expr stmt_list

%%

program:
        function        { exit(0); }
        ;

function:
        function stmt '\n' { ex($2); freeNode($2); }
        |
        ;

stmt:
                                { $$ = opr('\n', 2, NULL, NULL); }
    | expr                      { $$ = $1; }
    | PRINT expr                { $$ = opr(PRINT, 1, $2); }
    | VARIABLE INC1             { $$ = opr(INC1, 1, id($1)); }
    | VARIABLE DEC1             { $$ = opr(DEC1, 1, id($1)); }
    | VARIABLE '=' expr         { $$ = opr('=', 2, id($1), $3); }
    | VARIABLE ADDE expr        { $$ = opr(ADDE, 2, id($1), $3); }
    | VARIABLE SUBE expr        { $$ = opr(SUBE, 2, id($1), $3); }
    | VARIABLE MULE expr        { $$ = opr(MULE, 2, id($1), $3); }
    | VARIABLE DIVE expr        { $$ = opr(DIVE, 2, id($1), $3); }
    | WHILE '(' expr ')' stmt   { $$ = opr(WHILE, 2, $3, $5); }
    | IF '(' expr ')' stmt %prec IFX {
                                  $$ = opr(IF, 2, $3, $5); }
    | IF '(' expr ')' stmt ELSE stmt {
                                  $$ = opr(IF, 3, $3, $5, $7); }
    | '{' stmt_list '}'         { $$ = $2; }
    ;

stmt_list:
    stmt                        { $$ = $1; }
    | stmt_list '\n' stmt       { $$ = opr('\n', 2, $1, $3); }
    ;

expr:
        DOUBLE                { $$ = con($1); }
        | VARIABLE            { $$ = id($1); }
        | '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
        | expr '+' expr       { $$ = opr('+', 2, $1, $3); }
        | expr '-' expr       { $$ = opr('-', 2, $1, $3); }
        | expr '*' expr       { $$ = opr('*', 2, $1, $3); }
        | expr '/' expr       { $$ = opr('/', 2, $1, $3); }
        | expr '%' expr       { $$ = opr('%', 2, $1, $3); }
        | expr '^' expr       { $$ = opr('^', 2, $1, $3); }
        | expr '<' expr       { $$ = opr('<', 2, $1, $3); }
        | expr '>' expr       { $$ = opr('>', 2, $1, $3); }
        | expr GE expr        { $$ = opr(GE, 2, $1, $3); }
        | expr LE expr        { $$ = opr(LE, 2, $1, $3); }
        | expr NE expr        { $$ = opr(NE, 2, $1, $3); }
        | expr EQ expr        { $$ = opr(EQ, 2, $1, $3); }
        | '(' expr ')'        { $$ = $2; }
        ;

%%

nodeType *con(double value) {
    nodeType *p = (nodeType *)malloc(sizeof(nodeType));
    p->type = typeCon;
    p->con.value = value;
    return p;
}

nodeType *id(int i) {
    nodeType *p = (nodeType *)malloc(sizeof(nodeType));
    p->type = typeId;
    p->id.i = i;
    return p;
}

nodeType *opr(int oper, int nops, ...) {
    va_list ap;
    nodeType *p = (nodeType *) malloc(sizeof(nodeType));
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    p->opr.op = (nodeType **) malloc(nops * sizeof(nodeType *));
    va_start(ap, nops);
    for (int i = 0; i < nops; i++) {
        p->opr.op[i] = va_arg(ap, nodeType*);
    }
    va_end(ap);
    return p;
}

void freeNode(nodeType* p) {
    if (!p) return;
    if (p->type == typeOpr) {
        for (int i = 0; i < p->opr.nops; i++) {
            freeNode(p->opr.op[i]);
        }
        free(p->opr.op);
    }
    free(p);
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}