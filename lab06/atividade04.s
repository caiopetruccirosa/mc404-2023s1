.text
# Funcao TamanhoString
# Le uma string de ate 20 caracteres (+ 1 caracter terminador) do teclado e retorna o tamanho dela
# Parametros:
# - Nenhum
# Retorno:
# - tamanho da string (a0)
TamanhoString:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -29
    sw ra, sp, 0
    sw s0, sp, 4
    
    # Armazena o endereco de memoria alocado para a string (em s0)
    addi s0, sp, 8

    # Le uma string de 20 caracteres do teclado
    mv a0, s0
    li a1, 20
    li t0, 6
    ecall

    # Armazena o caracter terminador (ASCII 32) na ultima posicao da string
    li t0, 32
    sb t0, s0, 20

    # Chama a funcao strlen que retorna o tamanho da string (em a0)
    mv a0, s0
    call strlen

    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, sp, 0
    lw s0, sp, 4
    addi sp, sp, 29

    # Mantem o valor em a0 que tambem sera retornado em a0
    ret


# Funcao strlen
# Retorna o tamanho de uma string considerando o caracter ' ' como terminador
# Parametros:
# - s (a0): um endereco de memoria para o comeco de uma string
# Retorno:
# - tamanho da string (a0)
strlen:
    # Armazena o endereco de memoria da string (em t0), inicia um contador (em a0)
    #  e armazena o caracter terminador ' ' (ASCII 32) (em t1)
    mv t0, a0
    mv a0, zero
    li t1, 32

loop_contar_caracteres:
    # Carrega o caracter i da string (em t2)
    lb t2, t0, 0

    # Se o caracter atual for igual ao caracter ' ', termina a contagem
    beq t2, t1, fim_loop_contar_caracteres

    # Caso contrario, incrementa o contador de caracteres e o endereco de memoria e volta ao inicio do loop
    addi a0, a0, 1
    addi t0, t0, 1
    j loop_contar_caracteres

fim_loop_contar_caracteres:
    ret


main:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -4
    sw ra, sp, 0

    # Chama a funcao SomaVetor
    call TamanhoString

    # Imprime o tamanho da string lida na funcao
    # Valor a ser impresso ja esta em a0
    addi t0, zero, 1
    ecall

    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, sp, 0
    addi sp, sp, 4

    ret