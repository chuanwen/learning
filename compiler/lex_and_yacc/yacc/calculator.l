%{
#include <stdlib.h>
void yyerror(char *);
#include "calculator.tab.h"
%}

%%

sqrt        {
                yylval = 0;
                return FUNC;
            }

[a-z]       {
                yylval = *yytext - 'a';
                return VARIABLE;
            }

[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }

[-+*/)(=\n]      return *yytext;

[ \t]       ;

.           yyerror("invalid character");

%%

int yywrap(void) {
    return 1;
}
