#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "calculator.h"
#include "calculator.tab.h"

double ex(nodeType* p);
static int text_label=0;
static int data_label=0;
static bool symExist[26];

FILE* textF;
FILE* dataF;

void ex_init(int argc, char** argv) {
    for (int i=0; i < 26; i++) {
        symExist[i] = false;
    }
    textF = fopen("code.text", "w");
    dataF = fopen("code.data", "w");

    fprintf(textF, "\t\tSECTION .text\n");
    fprintf(dataF, "\t\tSECTION .data\n");
}

void ex_final(int argc, char** argv) {
    for (int i=0; i<26; i++) {
        if (symExist[i] == true) {
            fprintf(dataF, "VAR_%c:\t\tdq 0.0\n", i + 'a');
        }
    }
    fclose(textF);
    fclose(dataF);
    char cmd[256];
    memset(cmd, 0, sizeof(cmd));
    snprintf(cmd, sizeof(cmd), "./as.sh %s", argv[1]);
    system(cmd);
}

void EmitText(char* code) {
    fprintf(textF,"\t\t%s\n", code);
}

void EmitConst(double value) {
    char name[16];
    memset(name, 0, sizeof(name));
    snprintf(name, sizeof(name)-1, "CONST_%03d", data_label++);
    fprintf(dataF, "%s:\tdq %f\n", name, value);
    fprintf(textF,"\t\tfld qword [%s]\n", name);
}

void EmitVar(int index) {
    char name[16];
    memset(name, 0, sizeof(name));
    snprintf(name, sizeof(name), "VAR_%c", index+'a');
    fprintf(textF,"\t\tfld qword [%s]\n", name);
}

void EmitOpE(int index, char* oper) {
    char name[16];
    memset(name, 0, sizeof(name));
    snprintf(name, sizeof(name), "VAR_%c", index+'a');
    fprintf(textF,"\t\tfld qword [%s]\n", name);
    EmitText(oper);
    fprintf(textF,"\t\tfstp qword [%s]\n", name);
}


void EmitWhile(nodeType* cond_op, nodeType* cmd_op) {
    char labela[16], labelb[16], labelc[16];
    memset(labela, 0, sizeof(labela));
    memset(labelb, 0, sizeof(labelb));
    text_label++;
    snprintf(labela, sizeof(labela), "WHILE_s%03d", text_label);
    snprintf(labelb, sizeof(labelb), "WHILE_e%03d", text_label);
    fprintf(textF,"%s:\n", labela);
    ex(cond_op);
    fprintf(textF,"\t\tjz %s\n", labelb);
    ex(cmd_op);
    fprintf(textF,"\t\tjmp %s\n", labela);
    fprintf(textF,"%s:\n\n", labelb);
}

void EmitIf(nodeType* cmd_op) {
    char label[16];
    memset(label, 0, sizeof(label));
    text_label++;
    snprintf(label, sizeof(label), "IF_%03d", text_label);
    fprintf(textF,"\t\tjz %s\n", label);
    ex(cmd_op);
    fprintf(textF,"%s:\n\n", label);
}

void EmitIfElse(nodeType* if_cmd, nodeType* else_cmd) {
    char labela[16], labelb[16], labelc[16];
    memset(labela, 0, sizeof(labela));
    memset(labelb, 0, sizeof(labelb));
    text_label++;
    snprintf(labela, sizeof(labela), "ELSE_s%03d", text_label);
    snprintf(labelb, sizeof(labelb), "ELSE_t%03d", text_label);
    fprintf(textF,"\t\tjz %s\n", labela);
    ex(if_cmd);
    fprintf(textF,"\t\tjmp %s\n", labelb);
    fprintf(textF,"%s:\n", labela);
    ex(else_cmd);
    fprintf(textF,"%s:\n\n", labelb);
}


double ex(nodeType* p) {
    if (!p) return 0.0;
    nodeType** op = p->opr.op;
    switch(p->type) {
        case typeCon:
            EmitConst(p->con.value);
            break;
        case typeId:
            EmitVar(p->id.i);
            break;
        case typeOpr:
            switch(p->opr.oper) {
                case WHILE:
                    EmitWhile(op[0], op[1]);
                    break;
                case IF:
                    ex(op[0]);
                    if (p->opr.nops == 2) {
                        EmitIf(op[1]);
                    } else {
                        EmitIfElse(op[1], op[2]);
                    }
                    break;
                case PRINT:
                    ex(op[0]);
                    EmitText("print");
                    break;
                case '=':
                    ex(op[1]);
                    symExist[op[0]->id.i] = true;
                    fprintf(textF,"\t\tfstp qword [VAR_%c]\n", op[0]->id.i + 'a');
                    break;
                case UMINUS:
                    ex(op[0]);
                    EmitText("fchs");
                    break;
                case ADDE:
                    ex(op[1]); 
                    EmitOpE(op[0]->id.i, "fadd");
                    break;
                case SUBE:
                    ex(op[1]); 
                    EmitOpE(op[0]->id.i, "fsub");
                    break;
                case MULE:
                    ex(op[1]); 
                    EmitOpE(op[0]->id.i, "fmul");
                    break;
                case DIVE:
                    ex(op[1]); 
                    EmitOpE(op[0]->id.i, "fdiv");
                    break;                                        
                default:
                    ex(op[0]);
                    ex(op[1]);
                    switch(p->opr.oper) {
                        case '+': EmitText("fadd"); break;
                        case '-': EmitText("fsub"); break;
                        case '*': EmitText("fmul"); break;
                        case '/': EmitText("fdiv"); break;
                        case '<': EmitText("compLT"); break; 
                        case '>': EmitText("compGT"); break;
                        case GE:  EmitText("compGE"); break;
                        case LE:  EmitText("compLE"); break;
                        case NE:  EmitText("compNE"); break;
                        case EQ:  EmitText("compEQ"); break;
                    }
            }
    }
    return 0.0;
}


