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

enum instructiontype {
    UTYPE,
    STYPE,
    BTYPE,
    RTYPE,
    ITYPE,
    PSEUDO
} typedef InstructionType;

struct itypeinstruction {
    unsigned opcode:7;
    unsigned rd:5;
    unsigned funct3:3;
    unsigned rs1:5;
    unsigned imm:12;
} typedef ITypeInstruction;

struct rtypeinstruction {
    unsigned opcode:7;
    unsigned rd:5;
    unsigned funct3:3;
    unsigned rs1:5;
    unsigned rs2:5;
    unsigned funct7:7;
} typedef RTypeInstruction;

struct utypeinstruction {
    unsigned opcode:7;
    unsigned rd:5;
    unsigned imm:20;
} typedef UTypeInstruction;

struct sbtypeinstruction {
    unsigned opcode:7;
    unsigned imm5:5;
    unsigned funct3:3;
    unsigned rs1:5;
    unsigned rs2:5;
    unsigned imm7:7;
} typedef SBTypeInstruction;

/*
InstructionType read_instruction() {
    char ins[5], rd[5], rs1[5], rs2[5];
    int imm;
    scanf("%s", ins);
    if (strcmp(ins, "addi") == 0) {
        scanf("%s, %s, %d", rd, rs1, imm);
        ITypeInstruction encoded = {
            opcode: 0b0010011,
            rd: ,
            funct3: 0b000,
            rs1: ,
            imm: imm,
        };
    } else if (strcmp(ins, "slli") == 0) {
        scanf("%s, %s, %d", rd, rs1, imm);
        ITypeInstruction encoded = {
            opcode: 0b0010011,
            rd: ,
            funct3: 0b000,
            rs1: ,
            imm: imm,
        };
    } else if (strcmp(ins, "xor") == 0) {
        scanf("%s, %s, %s", rd, rs1, rs2);
        ITypeInstruction encoded = {
            opcode:
            rd:
            funct3:
            rs1:
            rs2:
            funct7:
        }
    } else if (strcmp(ins, "call") == 0) {
        scanf("%d", imm);
        return PSEUDO;
    } else if (strcmp(ins, "ret") == 0) {
        return PSEUDO;
    } else if (strcmp(ins, "beq") == 0) {
        scanf("%s, %s, %d", rs1, rs2, imm);
        return BTYPE;
    } else if (strcmp(ins, "lw") == 0) {
        scanf("%s, (%d)%s", rd, imm, rs1);
        return ITYPE;
    } else if (strcmp(ins, "sw") == 0) {
        scanf("%s, (%d)%s", rs2, imm, rs1);
        return STYPE;
    } else if (strcmp(ins, "mul") == 0) {
        scanf("%s, %s, %s", rd, rs1, rs2);
        return RTYPE;
    } else if (strcmp(ins, "lui") == 0) {
        scanf("%s, %d", rd, imm);
        return UTYPE;
    } else if (strcmp(ins, "li") == 0) {
        scanf("%s, %d", rd, imm);
        return PSEUDO;
    }
}

int get_register_value(char *res) {
    if (strcmp(res, "fp") == 0)
        return 8;
    char registers[32][5] = { "zero", "ra", "sp", "gp", "tp", "t0", "t1", "t2", "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6" };
    for (int i = 0; i < 32; i++)
        if (strcmp(res, registers[i]) == 0)
            return i;
    return -1;
}

int build_instruction(InstructionType t) {
    switch (t) {
    case UTYPE:
        break;
    case STYPE:
        break;
    case BTYPE:
        break;
    case RTYPE:
        break;
    case ITYPE:
        break;
    case PSEUDO:
        break;
    default:
        break;
    }
    if (strcmp(ins, "addi") == 0) {
        scanf("%s, %s, %d", rd, rs1, imm);
        ITypeInstruction encoded = {
            opcode: 0b0010011,
            rd: ,
            funct3: 0b000,
            rs1: ,
            imm: imm,
        };
    } else if (strcmp(ins, "slli") == 0) {
        scanf("%s, %s, %d", rd, rs1, imm);
        ITypeInstruction encoded = {
            opcode: 0b0010011,
            rd: ,
            funct3: 0b000,
            rs1: ,
            imm: imm,
        };
    } else if (strcmp(ins, "xor") == 0) {
        scanf("%s, %s, %s", rd, rs1, rs2);
    } else if (strcmp(ins, "call") == 0) {
        scanf("%d", imm);
    } else if (strcmp(ins, "ret") == 0) {

    } else if (strcmp(ins, "beq") == 0) {
        scanf("%s, %s, %d", rs1, rs2, imm);
    } else if (strcmp(ins, "lw") == 0) {
        scanf("%s, (%d)%s", rd, rs1, imm);
    } else if (strcmp(ins, "sw") == 0) {
        scanf("%s, (%d)%s", rs1, rs2, imm);
    } else if (strcmp(ins, "mul") == 0) {
        scanf("%s, %s, %s", rd, rs1, rs2);
    } else if (strcmp(ins, "lui") == 0) {
        scanf("%s, %d", rd, imm);
    } else if (strcmp(ins, "li") == 0) {
        scanf("%s, %d", rd, imm);
    } 
}
*/

int main() {
    return 0;
}