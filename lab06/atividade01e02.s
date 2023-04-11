.data
vetor:
    .word 10
    .word 20
    .word 30
    .word 40
    .word 50

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
    

# Funcao MultiplicaVetor
# Multiplica os elementos de um vetor v por um fator escalar
# Parametros:
# - N (a0): numero de elementos no vetor
# - v (a1): endereco de memoria do vetor
# - fator (a2): fator escalar que multipla os elementos do vetor
# Retorno:
# - Nenhum
MultiplicaVetor:
    # Movimenta o apontador da pilha 4 posicoes para baixo (16 bytes) e guarda 4 registradores na pilha
    addi sp, sp, -16
    sw s0, sp, 12
    sw s1, sp, 8
    sw s2, sp, 4
    sw ra, sp, 0

    # Armazena os parametros
    mv s0, a0 # s0 armazena N
    mv s1, a1 # s1 armazena v
    mv s2, a2 # s2 armazena fator

for_multiplicavetor:
    beq s0, zero, fim_multiplicavetor
    lw a0, s1, 0     # armazena o elemento v[i] em a0
    mv a1, s2        # armazena o fator em a1
    call Multiplica
    sw a0, s1, 0     # armazena o resultado da multiplicacao v[i]*fator em v[i]
    addi s1, s1, 4   # incrementa o indice i
    addi s0, s0, -1
    j for_multiplicavetor

fim_multiplicavetor:
    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, sp, 0
    lw s2, sp, 4
    lw s1, sp, 8
    lw s0, sp, 12
    addi sp, sp, 16
    ret


main:
    # Movimenta o apontador da pilha e armazena os registradores utilizados na pilha
    addi sp, sp, -4
    sw ra, sp, 0

    # Armazena o endereco de memoria de vetor (em s0),
    # o numero de elementos (em s1) e o fator de multiplicacao (em s2)
    lui s0, %hi(vetor)
    addi s0, s0, %lo(vetor)
    li s1, 5
    li s2, 10

    # Armazena os parametros em a0, a1 e a2
    mv a0, s1
    mv a1, s0
    mv a2, s2

    # Chama a funcao MultiplicaVetor
    call MultiplicaVetor

    # Movimenta o apontador da pilha e recupera os registradores utilizados da pilha
    lw ra, sp, 0
    addi sp, sp, 4

    ret