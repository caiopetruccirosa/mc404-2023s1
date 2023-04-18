.data
vetor_operacoes:
    .word 43 # caracter '+' na tabela ASCII
    .word 0x2c
    .word 45 # caracter '-' na tabela ASCII
    .word 0x34
    .word 42 # caracter '*' na tabela ASCII
    .word 0x3c

.text
# Funcao Soma
# Retorna a soma de dois numero
# Parametros: numero a (em a0) e numero b (em a1)
# Retorno: o resultado da soma a+b (em a0)
Soma:
    add a0, a0, a1
    ret

# Funcao Subtracao
# Retorna a subtracao de dois numero
# Parametros: numero a (em a0) e numero b (em a1)
# Retorno: o resultado da subtracao a-b (em a0)
Subtracao:
    sub a0, a0, a1
    ret

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

main:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -4
    sw ra, sp, 0

    # Carrega o endereco de memoria de vetor_operacoes
    lui s0, %hi(vetor_operacoes)
    addi s0, s0, %lo(vetor_operacoes)

    # Le os numeros e o caracter de operacao
    # Le um numero inteiro
    li t0, 4
    ecall
    mv s1, a0
    # Le um caracter
    li t0, 5
    ecall
    mv s2, a0
    # Le um numero inteiro
    li t0, 4
    ecall
    mv s3, a0

    # Escolha qual funcao chamar e chama ela
    # Inicia contador maximo de busca
    li t0, 3
    
for_busca_operacao:
    # Caso nao haja a operacao desejada, termina o programa
    beq t0, zero, fim
    
    # Carrega o caracter da operacao
    lw t1, s0, 0

    # Caso a operacao atual seja igual a desejada, termina a busca
    beq t1, s2, fim_busca_operacao

    # Decrementa o contador maximo e endereco de memoria do vetor
    addi t0, t0, -1
    addi s0, s0, 8
    j for_busca_operacao
fim_busca_operacao:

    # Carrega o endereco da funcao da operacao
    lw t0, s0, 4

    # Coloca os numeros como parametros em a0 e a1
    mv a0, s1
    mv a1, s3

    # Chama a funcao de operacao
    jalr ra, t0, 0

    # Imprime o resultado da operacao chamada
    # Valor a ser impresso ja esta em a0
    addi t0, zero, 1
    ecall

fim:
    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, sp, 0
    addi sp, sp, 4

    ret