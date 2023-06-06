.data
str1:
    .space 31 
    
.text
main:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)

    # Carrega enderecos da string e tamanho maximo
    la s0, str1
    li s1, 30

    # Chama fgets
    mv a0, s0
    mv a1, s1
    call fgets

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
    lw s1, 8(sp)
    addi sp, sp, 12

    # Encerra o programa
    li a0, 10
    ecall
    ret

# Funcao char* fgets(char *s, int N):
#   Le uma string do teclado com um tamanho maximo N
fgets:
    # Armazena registradores na pilha
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)

    # Define endereco da string e tamanho da string
    mv s0, a0
    mv s2, a1
    li s1, 0

    # Indica intencao de ler algo do teclado
    li a0, 0x130
    ecall

loop_fgets:
    # Termina a leitura se ja leu o numero maximo de caracteres
    bge s1, s2, fim_loop_fgets

    # Tenta fazer leitura de um caracter
    li a0, 0x131
    ecall

    # Termina o loop caso tenha lido todos os caracteres
    beq a0, zero, fim_loop_fgets

    # Recomeca o loop caso ainda nao haja caracter disponivel   
    li t0, 0x01
    beq a0, t0, loop_fgets  

    # Armazena caracter na string e incrementa tamanho
    sb a1, 0(s0)
    addi s0, s0, 1
    addi s1, s1, 1

    # Recomeca o loop
    j loop_fgets  

fim_loop_fgets:
    # Adiciona caracter nulo no fim da string
    sb zero, 1(s0)

    # Define retorno da funcao
    sub a0, s0, s1

    # Armazena registradores na pilha
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12

    ret
