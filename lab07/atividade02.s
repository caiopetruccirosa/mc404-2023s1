.text
main:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -4
    sw ra, 0(sp)

    # Carrega um valor no a0
    li a0, 4

    # Calcula o fatorial (parametro ja esta em a0)
    call Fatorial

    # Imprime o fatorial
    # Valor a ser impresso ja esta em a0
    mv a1, a0
    li a0, 1
    ecall

    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Encerra a execucao do programa
    li a0, 10
    ecall

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
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)

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
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
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
    sw ra, 0(sp)
    sw s0, 4(sp)
    
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
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8

    # Mantem o valor em a0 que tambem sera retornado em a0
    ret