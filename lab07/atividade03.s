.data
vetor:
    .word 10, 20, 30, 40, 50

.text
main:
    # Armazena o endereco de memoria de vetor (em s0),
    # o numero de elementos (em s1) e o fator de multiplicacao (em s2)
    la s0, vetor
    li s1, 5
    li s2, 2

    # Armazena os parametros em a0, a1 e a2
    mv a0, s1
    mv a1, s0
    mv a2, s2

    # Chama a funcao MultiplicaVetor
    call MultiplicaVetor

    # Encerra a execucao do programa
    li a0, 10
    ecall

# Funcao MultiplicaVetor
# Multiplica os elementos de um vetor v por um fator escalar
# Parametros:
# - N (a0): numero de elementos no vetor
# - v (a1): endereco de memoria do vetor
# - fator (a2): fator escalar que multipla os elementos do vetor
# Retorno:
# - Nenhum
MultiplicaVetor:
    # Movimenta o apontador da pilha 4 posicoes para baixo (16 bytes) e guarda 4 registradores na pilha
    addi sp, sp, -16
    sw s0, 12(sp)
    sw s1, 8(sp)
    sw s2, 4(sp)
    sw ra, 0(sp)

    # Armazena os parametros
    mv s0, a0 # s0 armazena N
    mv s1, a1 # s1 armazena v
    mv s2, a2 # s2 armazena fator

for_multiplicavetor:
    beq s0, zero, fim_multiplicavetor
    lw t0, 0(s1)     # armazena o elemento v[i] em a0
    mul t0, t0, s2
    sw t0, 0(s1)     # armazena o resultado da multiplicacao v[i]*fator em v[i]
    addi s1, s1, 4   # incrementa o indice i
    addi s0, s0, -1
    j for_multiplicavetor

fim_multiplicavetor:
    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, 0(sp)
    lw s2, 4(sp)
    lw s1, 8(sp)
    lw s0, 12(sp)
    addi sp, sp, 16
    ret