digit   [0-9]
letter  [A-Za-z]
%{
    int count;
%}
%%
    /* match identifier */
{letter}({letter}|{digit})*     printf("%4d\t%s\n", ++count, yytext);
.|\n                            ;
%%
int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}
