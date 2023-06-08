.data
buffer_str:
    .space 101
.text
main:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Le e imprime uma struct Pessoa
    call LePessoa
    call ImprimePessoa

    # Recupera registadores utilizados da pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Encerra o programa
    li a0, 10
    ecall

# Funcao void ImprimePessoa(Pessoa *p)
ImprimePessoa:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -4
    sw s0, 0(sp)

    # Guarda o ponteiro para Pessoa no s0
    mv s0, a0

    # Imprime o nome da pessoa
    li a0, 4
    lw a1, 0(s0)
    ecall

    # Imprime caracter de nova linha '\n'
    li a0, 11
    li a1, 13
    ecall

    # Imprime a idade da pessoa
    li a0, 1
    lw a1, 4(s0)
    ecall

    # Imprime caracter de nova linha '\n'
    li a0, 11
    li a1, 13
    ecall

    # Recupera registadores utilizados da pilha
    lw s0, 0(sp)
    addi sp, sp, 4
    ret

# Funcao Pessoa * LePessoa()
LePessoa:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)

    # Chama sbrk para alocar 58 bytes de memoria na heap
    li a0, 9
    li a1, 12
    ecall

    # Armazena o ponteiro para a struct alocada no s0
    mv s0, a0

    # Le o nome da Pessoa
    call LeString
    sw a0, 0(s0)

    # Le a idade da Pessoa
    call LeNumero
    sw a0, 4(s0)

    # Define o ponteiro da proxima Pessoa como NULL
    sw zero, 8(s0)

    # Define o ponteiro de Pessoa como o retorno
    mv a0, s0

    # Recupera registadores utilizados da pilha
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8
    ret

# Funcao int LeNumero()
LeNumero:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    # Armazena o numero em s0 e o sinal em s1
    mv s0, zero
    mv s1, zero

    # Inicia a leitura do teclado
    li a0, 0x130
    ecall

loop_LeNumero:
    # Tenta ler um caracter
    li a0, 0x131
    ecall

    # Interrompe o loop se acabou a leitura
    beq a0, zero, fim_loop_LeNumero

    # Se ainda nao tem caracter, recomeca o loop
    li    t0, 1
    beq   a0, t0, loop_LeNumero

    # Le o caracter
    mv t0, a1

    # Se for o sinal '-' e ainda nao apareceu um sinal
    li t1, 45
    bne t0, t1, nao_eh_sinal
    bne s1, zero, nao_eh_sinal

    # Atribui sinal ao s1
    li s1, 1
    j loop_LeNumero
    
nao_eh_sinal:

    # Se nao for um numero, termina o loop
    li t1, 48
    blt t0, t1, fim_loop_LeNumero 
    li t1, 58
    bge t0, t1, fim_loop_LeNumero 

    # Adiciona o digito no numero resultante
    addi t0, t0, -48
    li t1, 10
    mul s0, s0, t1
    add s0, s0, t0

    j loop_LeNumero

fim_loop_LeNumero:

    # Torna o numero negativo se tiver sinal
    beq s1, zero, nao_tem_sinal
    neg s0, s0

nao_tem_sinal:
    # Define o numero como retorno
    mv a0, s0

    # Recupera registadores utilizados da pilha
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    ret

# Funcao char * LeString()
LeString:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -4
    sw ra, 0(sp)

    # Le uma string de ate 100 caracteres no buffer
    la a0, buffer_str
    li a1, 100
    call fgets

    # Chama strlen
    call strlen

    # Chama sbrk para alocar memoria na heap
    addi a1, a0, 1
    li a0, 9
    ecall

    # Chama strcpy para copiar para a memoria
    la a1, buffer_str
    call strcpy

    # Recupera registadores utilizados da pilha
    lw ra, 0(sp)
    addi sp, sp, 4
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

# Funcao char* fgets(char *s, int N):
#   Le uma string do teclado com um tamanho maximo N
fgets:
    # Armazena registradores na pilha
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)

    # Define endereco da string e tamanho maximo da string
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
    sb zero, 0(s0)

    # Define retorno da funcao
    sub a0, s0, s1

    # Armazena registradores na pilha
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    ret