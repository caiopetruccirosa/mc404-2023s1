#include "stdio.h"
#include "string.h"

// addi:                    0biiiiiiiiiiiixxxxx000xxxxx0010011
// slli:                    0b0000000sssssxxxxx001xxxxx0010011
// xor:                     0b0000000xxxxxxxxxx100xxxxx0110011
// call -> jal ra, destino: 0biiiiiiiiiiiiiiiiiiii000011101111
// ret -> jalr zero, ra, 0: 0b00000000000000001000000001100111
// beq:                     0biiiiiiixxxxxxxxxx000iiiii1100011
// lw:                      0biiiiiiiiiiiixxxxx010xxxxx0000011
// sw:                      0biiiiiiixxxxxxxxxx010iiiii0100011
// mul:                     0b0000001xxxxxxxxxx000xxxxx0110011
// lui:                     0biiiiiiiiiiiiiiiiiiiixxxxx0110111
// li -> lui + addi:

int main() {
    // a maior instrução possível é addi com 4 caracteres + 1 caracter nulo
    // e o maior registrador possível é o zero com 4 caracteres + 1 caracter nulo
    char ins[5], res1[5], res2[5], res3[5];
    int imm;

    while (scanf("%s", ins) != EOF) {
        if (strcmp(ins, "addi") == 0) {
            scanf("%s, %s, %d", res1, res2, imm);
        } else if (strcmp(ins, "slli") == 0) {
            scanf("%s, %s, %d", res1, res2, imm);
        } else if (strcmp(ins, "xor") == 0) {
            scanf("%s, %s, %s", res1, res2, res3);
        } else if (strcmp(ins, "call") == 0) {
            scanf("%d", imm);
        } else if (strcmp(ins, "ret") == 0) {

        } else if (strcmp(ins, "beq") == 0) {
            scanf("%s, %s, %d", res1, res2, imm);
        } else if (strcmp(ins, "lw") == 0) {
            scanf("%s, (%d)%s", res1, res2, imm);
        } else if (strcmp(ins, "sw") == 0) {
            scanf("%s, (%d)%s", res1, res2, imm);
        } else if (strcmp(ins, "mul") == 0) {
            scanf("%s, %s, %s", res1, res2, res3);
        } else if (strcmp(ins, "lui") == 0) {
            scanf("%s, %d", res1, imm);
        } else if (strcmp(ins, "li") == 0) {
            scanf("%s, %d", res1, imm);
        } 
    }

    return 0;
}