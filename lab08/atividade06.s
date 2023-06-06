.data
str1:
    .string "Hello World!"
.text
main:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)

    la s0, str1

    mv a0, s0
    call strrev

    # Imprime a string
    li a0, 4
    mv a1, s0
    ecall
    # Imprime caracter de nova linha ('\n')
    li a0, 11
    li a1, 13
    ecall

    # Recupera registadores utilizados da pilha
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8

    # Encerra o programa
    li a0, 10
    ecall
    ret

# Funcao void strrev(char *s):
#   Reverte a string s
strrev:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)

    # Guarda o endereco da string s em s0
    mv s0, a0

    # Chama strlen cujo retorno fica em a0
    mv a0, s0
    call strlen

    # Guarda o endereco da primeira posicao da string s em s0
    # e da ultima posicao da string s em s1
    mv t0, s0
    add t1, s0, a0
    addi t1, t1, -1

loop_reverte:
    # Caso as posicoes sejam a mesma, termina o loop
    bge t0, t1, fim_loop_reverte

    # Troca os caracteres de posicao
    lbu t2, 0(t0)
    lbu t3, 0(t1)
    sb t2, 0(t1)
    sb t3, 0(t0)

    # Atualiza posicoes e recomeca o loop
    addi t0, t0, 1
    addi t1, t1, -1
    j loop_reverte

fim_loop_reverte:
    # Define o retorno como o endereco da string s revertida
    mv a0, s0

    # Recupera registadores utilizados da pilha
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8
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