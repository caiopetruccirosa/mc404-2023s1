main:
    # Le um caracter
    addi t0, zero, 5
    ecall
    add s0, zero, a0
    
    # Verifica se o caracter eh maiusculo ou minusculo
    # Armazena em t0 o valor de 'a'
    addi t0, zero, 97
    blt s0, t0, transforma_minusculo

    # Transforma o caracter em maiusculo
    andi s0, s0, 223
    
    j imprime

transforma_minusculo:
    # Transforma o caracter em minusculo
    ori s0, s0, 32

imprime:
    # Imprime um caracter
    add a0, zero, s0
    addi t0, zero, 2
    ecall

    # Imprime o caracter de quebra de linha
    addi a0, zero, 10
    addi t0, zero, 2
    ecall

    ret