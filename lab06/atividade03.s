.data
vetor:
    .word 10
    .word 20
    .word 30
    .word 40
    .word 50

.text
# Funcao SomaVetor
# Soma todos os elementos do vetor e retorna o valor da soma
# Parametros:
# - N (a0): numero de elementos no vetor
# - v (a1): endereco de memoria do vetor
# Retorno:
# - soma (a0): o resultado da soma de todos os elementos do vetor
SomaVetor:
    # Armazena o valor da soma em t0
    li t0, 0

for_soma:
    # Caso ja tenha somado todos elementos, finaliza o loop
    beq a0, zero, fim_soma

    # Carrega o elemento vetor[i] em t1
    lw t1, a1, 0

    # Incrementa a soma com t1
    add t0, t0, t1

    # Incrementa a posicao i do vetor, decrementa o numero de elementos e volta ao inicio do loop
    addi a0, a0, -1
    addi a1, a1, 4
    j for_soma

fim_soma:
    mv a0, t0

    ret


main:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -4
    sw ra, sp, 0

    # Armazena o endereco de memoria de vetor (em s0) e o numero de elementos (em s1)
    lui s0, %hi(vetor)
    addi s0, s0, %lo(vetor)
    li s1, 5

    # Armazena os parametros em a0 e a1
    mv a0, s1
    mv a1, s0

    # Chama a funcao SomaVetor
    call SomaVetor

    # Imprime o valor da soma
    # Valor a ser impresso ja esta em a0
    addi t0, zero, 1
    ecall

    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, sp, 0
    addi sp, sp, 4

    ret