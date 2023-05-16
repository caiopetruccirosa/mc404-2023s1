# RA: 248245
# Nome: Caio Petrucci dos Santos Rosa

.data
# Digitos descritos por linhas
# Cada linha ocupa 29 bits, sendo um entre cada bit (5 no total)
# e 4 bits por digito do RA (6 digitos no total)
# Para completar os 32 bits, existe um padding de 2 bits zerados 
# na esquerda e 1 bit zerado na direita
digitos_ra:
    .word 0b00011000001001100011001111001100
    .word 0b00100100011010010100101000010010
    .word 0b00100100101010010100101110010010
    .word 0b00001001111001100001000001001100
    .word 0b00010000001010010010000001010010
    .word 0b00100000001010010100000001010010
    .word 0b00111100001001100111101110001100

.text
main:
    # Carrega as linhas no registradores s1-s7
    la s0, digitos_ra

    # Armazena o numero de iteracoes que serão feitas para mostrar
    # todos os 32 bits na tela como um painel animado
    li s1, 47
loop_digitos:
    beq s1, zero, fim_main

    # Limpa a tela do robo
    call LimparTela

    # Monstra os digitos na tela de acordo com a iteracao
    mv a0, s0
    mv a1, s1
    call MostrarDigitos

    # Faz uma pausa para mostrar a animacao mais lentamente
    li a0, 500
    call Pausa

    addi s1, s1, -1
    j loop_digitos

fim_main:
    # Encerra o programa
    li a0, 10
    ecall

####################################

# Funcao MostrarDigitos que mostra na tela os digitos armazenados 
# na memoria de acordo com a iteracao/posicao que a animacao esta.
# Recebe o endereco de memoria do vetor com os digitos em a0 e a 
# iteracao atual em a1 (deve ser um numero entre 0 e 48)
MostrarDigitos:
    mv t0, a0
    mv t1, a1

    # 7 linhas para imprimir
    li t2, 7
loop_linhas:
    # Itera para cada linha
    beq t2, zero, fim_mostrar

    # Carrega os digitos da linha atual
    lw t3, 0(t0)

    # Se esta nas ultimas 16 iteracoes, faz o shift para esquerda
    # Caso contrario, faz o shift para a direita
    li t4, 16
    blt t1, t4, shift_esquerda
shift_direita:
    sub t4, t1, t4
    srl t3, t3, t4
    j fim_shift
shift_esquerda:
    sub t4, t4, t1
    sll t3, t3, t4
fim_shift:

    # Pinta os digitos na tela da linha atual
    # Os digitos serao pintados na tela das linhas 2 a 8
    li a0, 0x110
    addi a1, t2, 1
    mv a2, t3
    ecall

    addi t0, t0, 4
    addi t2, t2, -1
    j loop_linhas

fim_mostrar:
    ret

# Funcao Pausa que executa um laço contendo nop por N vezes (N = a0)
Pausa:
loop_pausa:
    beq a0, zero, fim_pausa
    nop
    addi a0, a0, -1
    j loop_pausa
fim_pausa:
    ret

# Funcao LimparTela limpa todos os bits da tela do robo
LimparTela:
    li t0, 12 # Limpa as 12 linhas
loop_limpar:
    beq t0, zero, fim_limpar
    addi t0, t0, -1
    li a0, 0x110  # Modo de pintura
    mv a1, t0     # Seleciona a linha i
    li a2, 0x0000 # Zera dos todos os bits da linha
    ecall
    j loop_limpar
fim_limpar:
    ret