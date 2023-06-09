# RA: 248245
# Nome: Caio Petrucci dos Santos Rosa

# Importa o pacote de regex da biblioteca padrao do Python
import re

# Constante que indica a posicao de uma instrucao para realizar
# o calculo do *offset* usado em instrucoes de salto
INSTRUCTION_POSITION = 1000

###
# Funcoes
###
def limit_bits(num, n):
    '''Limita o numero bits de um numero inteiro.

    Parametros:
    - num (int): numero a ser limitado
    - n (int): numero de bits que o retorno deve conter

    Retorno:
    - int: o numero 'num' contendo apenas 'n' bits
    '''
    lim = (1 << n) - 1
    return num & lim

def tokenize_instruction(raw_ins):
    '''Divide a instrucao 'ins' em tokens, substituindo uma sequencia composta pelos
    carateres '(', ')', ',' e ' ' pelo caracter ' ' e entao separando os tokens de 
    acordo com o delimitador ' '.

    Parametros:
    - raw_ins (string): uma instrucao RISC-V, como 'addi t0, t1, 10' ou 'lw s0, 0(s1)'.

    Retorno:
    - ins (list of string): uma lista de 'tokens' que descrevem a instrucao 'raw_ins'.
    '''
    return re.split('\s+', re.sub('[\s(),]+', ' ', raw_ins).strip().lower())

def preprocess_instruction(ins):
    '''Preprocessa uma instrucao dividida em tokens, reordenando estes tokens 
    dependendo da instrucao e, em alguns casos (para as instrucoes 'slli', 'beq' 
    e 'jal'), manipula os imediatos de acordo com a especificacao de codificacao 
    de instrucoes do RISC-V.

    Parametros:
    - ins (list of string): uma lista de 'tokens' que descrevem a instrucao uma instrucao do RISC-V

    Retorno:
    - ins (list of string): uma lista de 'tokens' que descrevem a instrucao processada
    conforme indicado.
    '''
    mne = ins[0]
    match mne:
        case 'lw':
            _, _, imm, rs2 = ins
            ins[2] = rs2
            ins[3] = imm
        case 'sw':
            _, rs2, imm, rs1 = ins
            ins[1] = rs1
            ins[2] = rs2
            ins[3] = imm
        case 'slli':
            imm = int(ins[3], base=0)
            limited_imm = limit_bits(imm, 5)
            ins[3] = str(limited_imm)
        case 'jal':
            imm = int(ins[2], base=0)
            offset = imm - INSTRUCTION_POSITION
            offset20 = limit_bits((offset >> 20), 1) << 19
            offset20 += limit_bits((offset >> 1), 10) << 9
            offset20 += limit_bits((offset >> 11), 1) << 8
            offset20 += limit_bits((offset >> 12), 8)
            offset20 = limit_bits(offset20, 20)
            ins[2] = str(offset20)
        case 'beq':
            imm = int(ins[3], base=0)
            offset = imm - INSTRUCTION_POSITION
            offset12 = limit_bits((offset >> 11), 1)
            offset12 += limit_bits((offset >> 1), 4) << 1
            offset12 += limit_bits((offset >> 5), 6) << 5
            offset12 += limit_bits((offset >> 12), 1) << 11
            offset12 = limit_bits(offset12, 12)
            ins[3] = str(offset12)
    return ins

def translate_pseudo(ins):
    '''Traduz uma instrucao para uma sequencia de instrucoes se for necessario,
    o que eh o caso de pseudoinstrucoes como 'li', 'call' e 'ret'.

    Parametros:
    - ins (list of string): uma instrucao RISC-V ja preprocessada.

    Retorno:
    - translated (list of list of string): uma lista de instrucoes nativas RISC-V 
    que equivalem a instrucao 'ins'.
    '''
    mne = ins[0]
    match mne:
        case 'li':
            # Transforma a instrucao 'li rd, imm' em:
            # - 'addi rd, rd, imm': caso o numero seja menor que 2^(11) e maior igual a -(2^(11))
            # - 'lui rd, imm[31:12]' + 'addi rd, rd, imm[11:0]': caso o numero nao possa ser representado
            #                                                    apenas com um 'addi' conforme a descricao acima. 
            # A conversao considera que todos os numeros estao representados em complemento de 2 e, portanto,
            # possuem sinal. Alem disso, em alguns casos, eh necessario levar em conta a extensao de sinal que
            # sera feita pelo 'addi' e seu efeito na construcao do numero 'imm'.
            rd = ins[1]
            imm = int(ins[2], base=0)
            lower_bits = limit_bits(imm, 12)
            upper_bits = limit_bits((imm >> 12), 20)
            if (imm >= (1 << 11)) or (imm < ((1 << 11)*(-1))):
                lower_sign = (lower_bits >> 11) & 1
                if lower_sign == 1:
                    upper_bits = limit_bits(upper_bits + 1, 20)
                return [['lui', rd, str(upper_bits)], ['addi', rd, rd, str(lower_bits)]]
            else:
                return [['addi', rd, 'zero', str(lower_bits)]]
        case 'call':
            # Transforma a instrucao 'call imm' em 'jal ra, imm'.
            return [['jal', 'ra', ins[1]]]
        case 'ret':
            # Transforma a instrucao 'ret' em 'jalr zero, ra, 0'.
            return [['jalr', 'zero', 'ra', '0']]
        case _:
            return [ins]

def encode_instruction(ins):
    '''Codifica uma instrucao nativa RISC-V.
    A lista de instrucoes que podem ser codificadas sao: 'addi', 'slli', 'xor', 'beq', 'lw', 'sw', 'mul', 'lui', 'jal' e 'jalr'.

    Parametros:
    - ins (list of string): uma instrucao nativa RISC-V ja preprocessada.

    Retorno:
    - encoded (int): um inteiro de 32 bits que descreve a instrucao 'ins' codificada de acordo com a especificacao do RISC-V.
    '''
    REGISTERS = { 'zero': 0, 'ra': 1, 'sp': 2, 'gp': 3, 'tp': 4, 't0': 5, 't1': 6, 't2': 7, 's0': 8, 'fp': 8, 's1': 9, 'a0': 10, 'a1': 11, 'a2': 12, 'a3': 13, 'a4': 14, 'a5': 15, 'a6': 16, 'a7': 17, 's2': 18, 's3': 19, 's4': 20, 's5': 21, 's6': 22, 's7': 23, 's8': 24, 's9': 25, 's10': 26, 's11': 27, 't3': 28, 't4': 29, 't5': 30, 't6': 31 }
    OPCODES = { 'addi': 19, 'slli': 19, 'xor': 51, 'beq': 99, 'lw': 3, 'sw': 35, 'mul': 51, 'lui': 55, 'jal': 111, 'jalr': 103 }
    FUNCT3 = { 'addi': 0, 'slli': 1, 'xor': 4, 'beq': 0, 'lw': 2, 'sw': 2, 'mul': 0, 'jalr': 0 }
    FUNCT7 = { 'slli': 0, 'xor': 0, 'mul': 1 }
    ITYPE = ['addi', 'jalr', 'lw', 'slli']
    RTYPE = ['xor', 'mul']
    UTYPE = ['lui', 'jal']
    SBTYPE = ['beq','sw']
    
    mne = ins[0]
    encoded = OPCODES[mne]
    if mne in RTYPE:
        _, rd, rs1, rs2 = ins
        encoded += limit_bits(REGISTERS[rd], 5)  << 7
        encoded += limit_bits(FUNCT3[mne], 3)    << 12
        encoded += limit_bits(REGISTERS[rs1], 5) << 15
        encoded += limit_bits(FUNCT7[mne], 7)    << 25
        encoded += limit_bits(REGISTERS[rs2], 5) << 20
    elif mne in UTYPE:
        rd = ins[1]
        imm = int(ins[2], base=0)
        encoded += limit_bits(REGISTERS[rd], 5) << 7
        encoded += limit_bits(imm, 20)          << 12
    elif mne in ITYPE:
        rd = ins[1]
        rs1 = ins[2]
        imm = int(ins[3], base=0)
        encoded += limit_bits(REGISTERS[rd], 5)  << 7
        encoded += limit_bits(FUNCT3[mne], 3)    << 12
        encoded += limit_bits(REGISTERS[rs1], 5) << 15
        encoded += limit_bits(imm, 12)           << 20
    elif mne in SBTYPE:
        rs1 = ins[1]
        rs2 = ins[2]
        imm = int(ins[3], base=0)
        encoded += limit_bits(imm, 5)            << 7
        encoded += limit_bits(FUNCT3[mne], 3)    << 12
        encoded += limit_bits(REGISTERS[rs1], 5) << 15
        encoded += limit_bits(REGISTERS[rs2], 5) << 20
        encoded += limit_bits((imm >> 5), 7)     << 25
    return limit_bits(encoded, 32)

###
# Main
###
if __name__ == '__main__':
    try:
        tokenized = tokenize_instruction(input())
        translated = translate_pseudo(tokenized)
        for instruction in translated:
            preprocessed = preprocess_instruction(instruction)
            encoded = encode_instruction(preprocessed)
            print(f'0x{encoded:08X}')
    except Exception as e:
        print(f'Erro de sintaxe na instrucao! Erro: {e}')
