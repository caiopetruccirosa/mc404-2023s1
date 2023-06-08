.data
str1:
    .string "Hello "
str2:
    .string "World!" 
    
.text
main:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)

    # Carrega enderecos das strings
    la s0, str1
    la s1, str2

    # Chama strlen
    mv a0, s0
    call strlen

    # Imprime o comprimento
    # Valor a ser impresso ja esta em a0
    mv a1, a0
    li a0, 1
    ecall
    # Imprime caracter de nova linha '\n'
    li a0, 11
    li a1, 13
    ecall

    # Chama strcmp
    mv a0, s0
    mv a1, s1
    call strcmp

    # Imprime a comparacao
    # Valor a ser impresso ja esta em a0
    mv a1, a0
    li a0, 1
    ecall
    # Imprime caracter de nova linha '\n'
    li a0, 11
    li a1, 13
    ecall

    # Chama strcat
    mv a0, s0
    mv a1, s1
    call strcat

    # Imprime a string
    li a0, 4
    mv a1, s0
    ecall
    # Imprime caracter de nova linha '\n'
    li a0, 11
    li a1, 13
    ecall

    # Recupera registadores utilizados da pilha
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12

    # Encerra o programa
    li a0, 10
    ecall
    ret

# Funcao int strlen(char *s):
#   Retorna o tamanho da string s
strlen:
    # Inicia um contador do comprimento
    li t0, 0
loop_strlen:
    # Se o caracter atual eh o caracter nulo, interrompe o loop
    lbu t1, 0(a0)
    beq t1, zero, fim_loop_strlen

    # Incrementa posicao na string e comprimento 
    addi a0, a0, 1
    addi t0, t0, 1

    # Recomeca o loop
    j loop_strlen

fim_loop_strlen:
    # Define o comprimento como retorno
    mv a0, t0
    ret

# Funcao int strcmp(char *s1, char *s2):
#   Compara as strings s1 e s2 e retorna 0 se as duas forem iguais,
#   -1 se s1 for menor que s2 e 1 se s1 for maior que s2
strcmp:
loop_strcmp:
    # Carrega um caracter de cada string
    lbu t0, 0(a0)
    lbu t1, 0(a1)

    # Se o caracter de s1 for menor que o de s2
    bge t0, t1, nao_eh_menor
    li t2, -1
    j fim_loop_strcmp
nao_eh_menor:

    # Se o caracter de s1 for maior que o de s2
    bge t1, t0, nao_eh_maior
    li t2, 1
    j fim_loop_strcmp
nao_eh_maior:

    # Se o caracter de s1 e de s2 for igual a zero
    bne t0, zero, nao_sao_zero
    li t2, 0
    j fim_loop_strcmp
nao_sao_zero:

    # Incrementa a posicao das strings
    addi a0, a0, 1
    addi a1, a1, 1

    # Recomeca o loop
    j loop_strcmp

fim_loop_strcmp:
    # Define o valor do retorno
    mv a0, t2
    ret

# Funcao char * strcat(char *s1, char *s2):
#   Concatena as strings s1 e s2 e armazena o resultado na string s1
strcat:
    # Inicia um contador de comprimento da string final
    li t1, 0

loop_strcat_s1:
    # Carrega o caracter da string s1
    lbu t0, 0(a0)

    # Caso seja o caracter nulo, termina o loop
    beq t0, zero, fim_loop_strcat_s1

    # Incrementa o endereco da string e o comprimento
    addi a0, a0, 1
    addi t1, t1, 1
    
    # Recomeca o loop
    j loop_strcat_s1
fim_loop_strcat_s1:

loop_strcat_s2:
    # Carrega o caracter da string s2
    lbu t0, 0(a1)

    # Caso seja o caracter nulo, termina o loop
    beq t0, zero, fim_loop_strcat_s2

    # Armazena o caracter da string s2 na string s1
    sb t0, 0(a0)

    # Incrementa os enderecos das strings e o comprimento da string resultante
    addi a0, a0, 1
    addi a1, a1, 1
    addi t1, t1, 1

    # Recomeca o loop
    j loop_strcat_s2

fim_loop_strcat_s2:
    # Armazena o caracter nulo na ultima posicao
    sb zero, 0(a0)

    # Define o endereco da string resultante como retorno
    sub a0, a0, t1
    ret