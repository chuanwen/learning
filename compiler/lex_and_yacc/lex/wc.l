%{
    int nchar, nword, nline;
%}
%%
\n          { nline++; nchar++; }
[^ \t\n]+   { nword++; nchar += yyleng; }
.           { nchar++; }
%%
int yywrap(void) {
    return 1;
}

int main(int argc, char* argv[]) {
    yyin = fopen(argv[1], "r");
    yylex();
    printf("%d\t%d\t%d\t%s\n", nline, nword, nchar, argv[1]);
}
