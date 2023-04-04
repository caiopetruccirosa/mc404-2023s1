.rodata
vetor_pontos:
    .word 1
    .word 0
    .word 1
    .word 5
    .word 5
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0

.text
main:
    # Armazena em s0 o endereco de vetor_pontos
    lui s0, %hi(vetor_pontos)
    addi s0, s0, %lo(vetor_pontos)

    # Armazena em s1 e s2 o ponto mais superior (s1: x, s2: y)
    add s1, zero, zero
    add s2, zero, zero

    # Inicia contador para percorrer o vetor em s11 e o um limite em s10
    add s11, zero, zero

loop_busca:
    # Verifica se o contador passou do limite e, se sim, termina o loop
    addi t0, zero, 40
    bge s11, t0, fim_loop_busca

    # Carrega em s3 e s4 o ponto atual (s3: x, s4: y)
    add t0, s0, s11
    lw s3, t0, 0
    add t0, s0, s11
    lw s4, t0, 4

    # Verifica se o ponto eh o mais a direita e o mais superior em caso de empate
    blt s1, s3, ponto_maior
    bne s1, s3, ponto_menor
    blt s2, s4, ponto_maior
    j ponto_menor

ponto_maior:
    # Reatribui o maior ponto
    add s1, zero, s3
    add s2, zero, s4
ponto_menor:

    # Incrementa o contador
    addi s11, s11, 8
    j loop_busca
fim_loop_busca:

imprime_ponto:
    #
    # Imprime o ponto como (x, y)
    #

    # Imprime o caracter (
    addi a0, zero, 40
    addi t0, zero, 2
    ecall
    # Imprime o valor x do ponto
    addi a0, s1, 48
    addi t0, zero, 2
    ecall
    # Imprime o caracter ,
    addi a0, zero, 44
    addi t0, zero, 2
    ecall
    # Imprime o caracter ' '
    addi a0, zero, 32
    addi t0, zero, 2
    ecall
    # Imprime o valor y do ponto
    addi a0, s2, 48
    addi t0, zero, 2
    ecall
    # Imprime o caracter )
    addi a0, zero, 41
    addi t0, zero, 2
    ecall
    # Imprime o caracter '\n'
    addi a0, zero, 10
    addi t0, zero, 2
    ecall

    ret
