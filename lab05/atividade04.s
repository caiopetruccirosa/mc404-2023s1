.data
matriz:
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0

.text
main:
    # Armazena em s0 o endereco de matriz
    lui s0, %hi(matriz)
    addi s0, s0, %lo(matriz)

    # Inicia contador com 0 em s1 e limite de 24 (4*6) em s2
    add s1, zero, zero
    addi s2, zero, 24
    
    # Armazena os valores de i e j em s3 e s4 respectivamente
    add s3, zero, zero
    add s4, zero, zero

loop_matriz:
    bge s1, s2, fim_loop_matriz

    # Armazena o valor de i+j em s5
    add s5, s3, s4

    # Armazena a posicao de memoria do indice (i, j) da matriz em t0
    add t0, s0, s1

    # Guarda a soma no posicao (i, j) da matriz
    sw s5, t0, 0

    # Atualiza os valores de i e j
    addi s4, s4, 1                 # Incrementa o valor de j
    addi t0, zero, 3
    blt s4, t0, nao_pulou_de_linha # Verifica se pulou de linha na matriz
    add s4, zero, zero             # Reatribui o valor de j para 0
    addi s3, s3, 1                 # Incrementa o valor de i
nao_pulou_de_linha:
    # Incrementa o contador
    addi s1, s1, 4

    # Volta ao inicio do loop
    j loop_matriz
fim_loop_matriz:

    ret
