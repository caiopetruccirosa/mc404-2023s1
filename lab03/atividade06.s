main:
    # Le um numero do teclado e armazena em s0
    # addi t0, zero, 4
    # ecall
    # add s0, zero, a0
    addi s0, zero, 5

    # Inicia um contador em s1 para realizar 32 iteracoes
    addi s1, zero, 31

loop:
    # Encerra o loop quando termina as iteracoes
    blt s1, zero, fim

    ## Armazena o bit atual em s2
    # Faz o shift para esquerda em s0 para pegar o iesimo bit onde i = s1+1
    srl s2, s0, s1
    # Pega o primeiro bit de s2 realizando um and com 1
    andi s3, s2, 1
    
    # Imprime o bit atual como caracter
    addi a0, s3, 48
    addi t0, zero, 2
    ecall

    # Decrementa o contador e volta para o inicio do loop
    addi s1, s1, -1
    j loop

fim:
    # Imprime o caracter de quebra de linha
    addi a0, zero, 10
    addi t0, zero, 2
    ecall

    ret