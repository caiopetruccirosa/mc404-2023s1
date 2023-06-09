# RA: 248245
# Nome: Caio Petrucci dos Santos Rosa

.data
# Digitos do RA descritos por linhas:
#  Os digitos ocupam 24 bits (4 bits por digito e 6 digitos no total)
#  e existe 1 bit zerado entre cada digito (5 bits no total). Adicionalmente,
#  existe um padding de 2 bits zerados na esquerda e 1 bit zerado na direita.
#  Dessa forma, cada linha é representada por 32 bits no total.
digitos_ra:
    .word 0b00011000001001100011000001011110
    .word 0b00100100011010010100100011010000
    .word 0b00100100101010010100100101010000
    .word 0b00000101001010010000101001010000
    .word 0b00000101001001100000101001011100
    .word 0b00001001111010010001001111000010
    .word 0b00010000001010010010000001000010
    .word 0b00100000001010010100000001000010
    .word 0b00100000001010010100000001000010
    .word 0b00111100001001100111100001011100

.text
main:
    # Armazena os registradores na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    
    # Carrega o vetor de linhas no registrador s0
    la s0, digitos_ra

    # Armazena o numero de iteracoes que serao feitas para 
    # mostrar todos os 32 bits na tela como um painel animado
    li s1, 47
loop_digitos:
    beq s1, zero, fim_main

    # Mostra os digitos na tela de acordo com a iteracao atual
    mv a0, s0
    mv a1, s1
    call MostrarDigitos

    # Faz uma pausa para mostrar a animacao mais lentamente
    li a0, 350
    call Pausa

    addi s1, s1, -1
    j loop_digitos

fim_main:
    # Recupera os registradores da pilha
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12

    # Encerra o programa
    li a0, 10
    ecall

####################################
# Funcoes Auxiliares
####################################

# Funcao Pausa:
#  Executa um laço, contendo nop, por N vezes. 
#  O parametro N eh recebido em a0.
Pausa:
loop_pausa:
    beq a0, zero, fim_pausa
    nop
    addi a0, a0, -1
    j loop_pausa
fim_pausa:
    ret

# Funcao MostrarDigitos: 
#  Mostra na tela os digitos armazenados na memoria de acordo com a iteracao/posicao 
#  que a animacao esta. Recebe o endereco de memoria do vetor com os digitos em a0 e 
#  a iteracao atual em a1 (deve ser um numero entre 0 e 47, possibilitando 48 iteracoes).
MostrarDigitos:
    # Armazena os registradores na pilha, pois a funcao nao eh folha ja que possui uma chamada ecall
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)

    # Armazena os parametros no s0 e s1
    mv s0, a0
    mv s1, a1

    # 10 linhas para imprimir
    li s2, 10
loop_linhas:
    # Itera para cada linha
    beq s2, zero, fim_mostrar

    # Carrega os digitos da linha atual
    lw s3, 0(s0)

    # Se esta nas ultimas 16 iteracoes, faz o shift para esquerda
    # Caso contrario, faz o shift para a direita
    li s4, 16
    blt s1, s4, shift_esquerda
    sub s4, s1, s4
    srl s3, s3, s4
    j fim_shift
shift_esquerda:
    sub s4, s4, s1
    sll s3, s3, s4
fim_shift:

    # Pinta os digitos na tela da linha atual
    # Os digitos serao pintados na tela das linhas 1 a 10
    li a0, 0x110
    mv a1, s2
    mv a2, s3
    ecall

    addi s0, s0, 4
    addi s2, s2, -1
    j loop_linhas

fim_mostrar:
    # Recupera os registradores da pilha
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    addi sp, sp, 20
    ret