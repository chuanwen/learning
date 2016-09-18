#include <stdio.h>

typedef enum { typeCon, typeId, typeOpr} nodeEnum;

/* constants */
typedef struct {
    double value;
} conNodeType;

/* identifiers */
typedef struct {
    int i;
} idNodeType;

/* operators */
typedef struct {
    int oper;
    int nops;
    struct nodeType_ **op;
} oprNodeType;

typedef struct nodeType_ {
    nodeEnum type;
    union {
        conNodeType con;
        idNodeType id;
        oprNodeType opr;
    };
} nodeType;

extern double symtable[26];
