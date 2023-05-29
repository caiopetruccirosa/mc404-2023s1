# RA: 248245
# Nome: Caio Petrucci dos Santos Rosa

# REVISAR CALL
# REVISAR BEQ
# REVISAR LW
# REVISAR SW

import re
from ctypes import c_int32

registradores = { "zero": 0, "ra": 1, "sp": 2, "gp": 3, "tp": 4, "t0": 5, "t1": 6, "t2": 7, "s0": 8, "fp": 8, "s1": 9, "a0": 10, "a1": 11, "a2": 12, "a3": 13, "a4": 14, "a5": 15, "a6": 16, "a7": 17, "s2": 18, "s3": 19, "s4": 20, "s5": 21, "s6": 22, "s7": 23, "s8": 24, "s9": 25, "s10": 26, "s11": 27, "t3": 28, "t4": 29, "t5": 30, "t6": 31 }
# opcodes = { "addi": 0b0010011, "slli": 0b0010011, "xor": 0b0110011, "beq": 0b1100011, "lw": 0b0000011, "sw": 0b0100011, "mul": 0b0110011, "lui": 0b0110111, "jal": 0b1101111, "jalr": 0b1100111 }
# funct3 = { "addi": 0b000, "slli": 0b001, "xor": 0b100, "beq": 0b000, "lw": 0b010, "sw": 0b010, "mul": 0b000, "jalr": 0b000 }
# funct7 = { "slli": 0b0000000, "xor": 0b0000000, "mul": 0b0000001 }

def encode_instruction(inst):
    encoded_instructions = []
    match inst[0]:
        case "addi":
            # addi: 0biiiiiiiiiiiixxxxx000xxxxx0010011
            encoded = 0b00000000000000000000000000010011
            encoded += registradores[inst[1]] << 7
            encoded += registradores[inst[2]] << 15
            encoded += int(inst[3]) << 20
            encoded_instructions.append(c_int32(encoded).value)
        case "slli":
            # slli: 0b0000000sssssxxxxx001xxxxx0010011
            encoded = 0b00000000000000000001000000010011
            encoded += registradores[inst[1]] << 7
            encoded += registradores[inst[2]] << 15
            encoded += (c_int32((int(inst[3]) << 25)).value >> 5)
            encoded_instructions.append(c_int32(encoded).value)
        case "xor":
            # xor: 0b0000000xxxxxxxxxx100xxxxx0110011
            encoded = 0b00000000000000000100000000110011
            encoded += registradores[inst[1]] << 7
            encoded += registradores[inst[2]] << 15
            encoded += registradores[inst[3]] << 20
            encoded_instructions.append(c_int32(encoded).value)
        case "call":
            # call -> jal ra, destino: 0biiiiiiiiiiiiiiiiiiii000011101111
            pc = 1000
            encoded = 0b00000000000000000000000011101111
            encoded += (((int(inst[1])-1000)) >> 1) << 12
            encoded_instructions.append(c_int32(encoded).value)
        case "ret":
            # ret -> jalr zero, ra, 0: 0b00000000000000001000000001100111
            encoded_instructions.append(0b00000000000000001000000001100111)
        case "beq":
            # beq: 0biiiiiiixxxxxxxxxx000iiiii1100011
            offset = int(inst[3])
            encoded = 0b00000000000000000000000001100011
            encoded += registradores[inst[1]] << 15
            encoded += registradores[inst[2]] << 20
            encoded += ((offset & 0b11110) + ((offset & 0b100000000000) >> 11)) << 7
            encoded += (((offset & 0b11111100000) >> 5) + (((offset & 0b1000000000000) >> 12) << 6)) << 25
            encoded_instructions.append(c_int32(encoded).value)
        case "lw":
            # lw: 0biiiiiiiiiiiixxxxx010xxxxx0000011
            encoded = 0b00000000000000000000000001100011
            encoded += registradores[inst[1]] << 7
            encoded += registradores[inst[3]] << 15
            encoded += int(inst[2]) << 20
            encoded_instructions.append(c_int32(encoded).value)
        case "sw":
            # sw: 0biiiiiiixxxxxxxxxx010iiiii0100011
            encoded = 0b00000000000000000000000001100011
            encoded += registradores[inst[1]] << 15
            encoded += registradores[inst[3]] << 20
            encoded += (int(inst[2]) & 0b11111) << 7
            encoded += (int(inst[2]) & 0b111111100000) << 25
            encoded_instructions.append(c_int32(encoded).value)
        case "mul":
            # mul: 0b0000001xxxxxxxxxx000xxxxx0110011
            encoded = 0b00000010000000000000000000110011
            encoded += registradores[inst[1]] << 7
            encoded += registradores[inst[2]] << 15
            encoded += registradores[inst[3]] << 20
            encoded_instructions.append(c_int32(encoded).value)
        case "lui":
            # lui: 0biiiiiiiiiiiiiiiiiiiixxxxx0110111
            encoded = 0b0110111
            encoded += registradores[inst[1]] << 7
            encoded += int(inst[2]) << 12
            encoded_instructions.append(c_int32(encoded).value)
        case "li":
            # li -> lui + addi: 0biiiiiiiiiiiiiiiiiiiixxxxx0110111 + 0biiiiiiiiiiiixxxxx000xxxxx0010011
            # addi: 0biiiiiiiiiiiixxxxx000xxxxx0010011
            imm = int(inst[2])
            upper_limit = 1 << 12
            if imm >= upper_limit:
                encoded = 0b0110111
                encoded += registradores[inst[1]] << 7
                encoded += (imm >> 12) << 12
                encoded_instructions.append(c_int32(encoded).value)
            encoded = 0b00000000000000000000000000010011
            encoded += registradores[inst[1]] << 7
            encoded += registradores[inst[1]] << 15
            encoded += imm << 20
            encoded_instructions.append(c_int32(encoded).value)
    return tuple(encoded_instructions)

inst = re.split("\s+", input().lower().strip().replace(',',' ').replace('(',' ').replace(')',' '))
encoded_insts = encode_instruction(inst)

for e in encoded_insts:
    print(f'0x{e:08X}')