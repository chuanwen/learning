#include <stdio.h>
#include <math.h>
#include "calculator.h"
#include "calculator.tab.h"

#define EPS 1e-16

double double_abs(double x) {
    if (x > 0.0) {
        return x;
    }
    return -x;
}

double ex(nodeType *p) {
    if (!p) return 0.0;
    nodeType** op = p->opr.op;
    double ans;
    switch(p->type) {
        case typeCon:           return p->con.value;
        case typeId:            return symtable[p->id.i];
        case typeOpr:
            switch(p->opr.oper) {
                case WHILE:     while(ex(op[0])) {
                                    ex(op[1]);
                                }
                                return 0;
                case IF:        if (ex(op[0])) {
                                    ex(op[1]);
                                } else if (p->opr.nops > 2) {
                                    ex(op[2]); 
                                }
                                return 0;
                case PRINT:     ans = ex(op[0]);
                                if (double_abs(ans - (int)ans) <= 1e-16) {
                                    printf("%d\n", (int) ans);
                                } else {
                                    printf("%f\n", ans);
                                }
                                return 0;
                case '\n':      ex(op[0]);
                                return ex(op[1]);
                case INC1:      return symtable[op[0]->id.i] += 1;
                case DEC1:      return symtable[op[0]->id.i] -= 1;
                case '=':       return symtable[op[0]->id.i] = ex(op[1]);
                case ADDE:      return symtable[op[0]->id.i] += ex(op[1]);
                case SUBE:      return symtable[op[0]->id.i] -= ex(op[1]);
                case MULE:      return symtable[op[0]->id.i] *= ex(op[1]);
                case DIVE:      return symtable[op[0]->id.i] /= ex(op[1]);
                case UMINUS:    return -ex(op[0]);
                case '+':       return ex(op[0]) + ex(op[1]);
                case '-':       return ex(op[0]) - ex(op[1]);
                case '*':       return ex(op[0]) * ex(op[1]);
                case '/':       return ex(op[0]) / ex(op[1]);
                case '%':       return (int) ex(op[0]) % (int) ex(op[1]);
                case '^':       return pow(ex(op[0]), ex(op[1]));
                case '<':       return ex(op[0]) < ex(op[1]);
                case '>':       return ex(op[0]) > ex(op[1]);
                case LE:        return ex(op[0]) <= ex(op[1]);
                case GE:        return ex(op[0]) >= ex(op[1]);
                case NE:        return double_abs(ex(op[0]) - ex(op[1])) > EPS;
                case EQ:        return double_abs(ex(op[0]) - ex(op[1])) <= EPS;
                
            }
    }
}