.data
str1:
    .space 31 
    
.text
main:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)

    # Carrega enderecos da string
    la s0, str1

    # Chama gets
    mv a0, s0
    call gets

    # Imprime a string lida
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

# Funcao char* gets(char *s):
#   Le uma string do teclado
gets:
    # Armazena registradores na pilha
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    # Define endereco da string e tamanho da string
    mv s0, a0
    li s1, 0

    # Indica intencao de ler algo do teclado
    li a0, 0x130
    ecall

loop_gets:
    # Tenta fazer leitura de um caracter
    li a0, 0x131
    ecall

    # Termina o loop caso tenha lido todos os caracteres
    beq a0, zero, fim_loop_gets

    # Recomeca o loop caso ainda nao haja caracter disponivel   
    li t0, 0x01
    beq a0, t0, loop_gets  

    # Armazena caracter na string e incrementa tamanho
    sb a1, 0(s0)
    addi s0, s0, 1
    addi s1, s1, 1

    # Recomeca o loop
    j loop_gets  

fim_loop_gets:
    # Adiciona caracter nulo no fim da string
    sb zero, 1(s0)

    # Define retorno da funcao
    sub a0, s0, s1

    # Armazena registradores na pilha
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8

    ret
