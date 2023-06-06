.data
str1:
    .string "Hello World!\n" # tamanho de 14 caracteres contando caracter nulo
str2: 
    .space 14

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

    # Chama strcpy
    mv a0, s1
    mv a1, s0
    call strcpy

    # Imprime string copiada
    li a0, 4
    mv a1, s1
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

# Funcao char* strcpy(char *s1, char *s2):
#   Copia o conteudo da string s2 para a string s1 e 
#   retorna um ponteiro para o inicio da string s1
strcpy:
    li t0, 0
loop_strcpy:
    lbu t1, 0(a1)
    sb t1, 0(a0)
    addi a0, a0, 1
    addi a1, a1, 1
    addi t0, t0, 1
    bne t1, zero, loop_strcpy
fim_loop_strcpy:
    sub a0, a0, t0
    ret