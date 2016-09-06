    /* This section is for definitions */

%%
    /* This section is for rules */

    /* match everything except newline */
.   ECHO;
    /* match newline */
\n  ECHO;

%%

    /* This section is for subroutines */

/*
 * Function yywrap is called by lex when input is exhausted. 
 * Return 1 if you are done or 0 if more processing is required.
 */
int yywrap(void) {
    return 1; 
}

int main(void) {
    yylex();
    return 0;
}
