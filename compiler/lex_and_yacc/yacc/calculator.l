%{
#include <stdlib.h>
#include "calculator.h"
#include "calculator.tab.h"
void yyerror(char *);
%}

%%

[a-z]   {
        yylval.sIndex = *yytext - 'a';
        return VARIABLE;
    }

([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)   {
        yylval.dValue = atof(yytext);
        return DOUBLE;
    }

[-+*/)(=<>{}.;,!^%\n]      return *yytext;

"+="        return ADDE;
"-="        return SUBE;
"*="        return MULE;
"/="        return DIVE;

"++"        return INC1;
"--"        return DEC1;

"pi"        {
                yylval.dValue = 3.14159265358979323846;
                return DOUBLE;
            }


">="        return GE;
"<="        return LE;
"=="        return EQ;
"!="        return NE;
"while"     return WHILE;
"if"        return IF;
"else"      return ELSE;
"print"     return PRINT;

[ \t]+       ; /* ignore whitespace */

.           yyerror("invalid character");

%%

int yywrap(void) {
    return 1;
}
