.text
# Funcao Multiplica
# Multiplica dois numeros a e b
# Parametros:
# - a (a0): numero inteiro positivo (unsigned int)
# - b (a1): numero inteiro positivo (unsigned int)
# Retorno:
# - c (a0): resultado da multiplicacao a*b
Multiplica:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -20
    sw s0, sp, 0
    sw s1, sp, 4
    sw s2, sp, 8
    sw s3, sp, 12
    sw ra, sp, 16

    # Armazena os parametros (a em s0 e b em s1)
    mv s0, a0
    mv s1, a1

    # Armazena o produto da multiplicacao (em s3) e o contador de bits (em s4)
    li s2, 0
    li s3, 32

for_multiplica:
    # Se ja passou por todos os bits ou se nao tem mais 1s em s1,
    # Finaliza a multiplicacao
    beq s3, zero, fim_multiplica
    beq s1, zero, fim_multiplica

    # Se o bit atual de s1 eh 1, incrementa o produto
    andi t0, s1, 1
    beq t0, zero, shift_valores

    # Incrementa o produto
    add s2, s2, s0

shift_valores:
    # Faz o shift dos valores s0 = s0 mult 2 e s1 = s1 div 2
    slli s0, s0, 1
    srli s1, s1, 1

    # Decrementa o contador e volta para o inicio do loop
    addi s3, s3, -1
    j for_multiplica

fim_multiplica:
    # Armazena o retorno da funcao em a0
    mv a0, s2

    # Movimenta o apontador da pilha e recupera os registradores utilizados na pilha
    lw s0, sp, 0
    lw s1, sp, 4
    lw s2, sp, 8
    lw s3, sp, 12
    lw ra, sp, 16
    addi sp, sp, 20
    ret


# Funcao Fatorial
# Calcula o fatorial de um numero n
# Parametros:
# - n (a0): numero inteiro positivo (unsigned int)
# Retorno:
# - fatorial (a0): fatorial de n
Fatorial:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -8
    sw ra, sp, 0
    sw s0, sp, 4
    
    # Armazena o valor de n (em s0)
    mv s0, a0

    # Adiciona caso base onde n menor igual 1 e o fatorial eh 1
    li a0, 1
    bge a0, s0, fim_fatorial

    # Calcula o fatorial de n-1
    addi a0, s0, -1
    call Fatorial

    # Multiplica os valores n (em s0) e fatorial de n-1 (em a0)
    mv a1, s0
    call Multiplica

fim_fatorial:
    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, sp, 0
    lw s0, sp, 4
    addi sp, sp, 8

    # Mantem o valor em a0 que tambem sera retornado em a0
    ret


main:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -4
    sw ra, sp, 0

    # Le um numero do teclado e armazena em a0
    addi t0, zero, 4
    ecall

    # Calcula o fatorial (parametro ja esta em a0)
    call Fatorial

    # Imprime o fatorial
    # Valor a ser impresso ja esta em a0
    addi t0, zero, 1
    ecall

    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, sp, 0
    addi sp, sp, 4

    ret