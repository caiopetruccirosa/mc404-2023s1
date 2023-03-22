main:
    # Armazena a soma dos pares em s0
    # E armazena a soma dos impares em s1
    add s0, zero, zero
    add s1, zero, zero

loop:
    # Le um numero do teclado e armazena em s2
    addi t0, zero, 4
    ecall
    add s2, zero, a0

    # Se o numero digitado for 0, para o loop
    beq s2, zero, fim_loop

    # Verifica se o numero em s2 eh par e armazena em s3
    andi s3, s2, 1

    # Se s3 == 0 entao o numero eh par senao o numero eh impar
    beq s3, zero, eh_par

    # Adiciona a soma de impares
    add s1, s1, s2
    j loop
    
eh_par:
    # Adiciona a soma de pares
    add s0, s0, s2
    j loop

fim_loop:
    # Armazena a subtracao soma_impares - soma_pares em s3
    sub s3, s1, s0

    ## Imprime o resultado da subtracao na saida

    # Se o resultado for maior que zero, imprime sem sinal de menos
    bge s3, zero, imprime_numero

    # torna o numero em s3 positivo
    sub s3, zero, s3

    # imprime o sinal de menos e o numero transformado em positivo
    addi a0, zero, 45
    addi t0, zero, 2
    ecall

imprime_numero:
    add a0, zero, s3
    addi t0, zero, 1
    ecall

    ret