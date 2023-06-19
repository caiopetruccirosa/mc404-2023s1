.text
main:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -4
    sw ra, 0(sp)

    # Le o numero N
    call LeNumero
    mv s0, a0

    # Aloca um vetor de pontos com N posicoes
    li t0, 12
    mul t0, s0, t0
    sub sp, sp, t0

    # Armazena o ponteiro do inicio do vetor e o tamanho do vetor
    mv s1, sp
    mv s2, s0
loop_LerPontos:
    # Se nao tem mais pontos para ler, termina o loop
    beq s2, zero, fim_loop_LerPontos

    # Le um ponto e armazena ele no endereco atual do vetor
    mv a0, s1
    call LePonto

    # Decrementa o contador, atualiza a posicao atual do vetor e recomeca o loop
    addi s1, s1, 12
    addi s2, s2, -1
    j loop_LerPontos
fim_loop_LerPontos:

    # Armazena o ponteiro do inicio do vetor e o tamanho do vetor
    mv s1, sp
    mv s2, s0
loop_PintaPontos:
    # Se nao tem mais pontos para ler, termina o loop
    beq s2, zero, fim_loop_PintaPontos

    # Mostra o ponto (x,y) na tela
    lw t0, 0(s1)
    lw t1, 4(s1)
    lw t2, 8(s1)
    
    slli t0, t0, 16

    li a0, 0x100
    add a1, t0, t1
    mv a2, t2
    ecall

    # Decrementa o contador, atualiza a posicao atual do vetor e recomeca o loop
    addi s1, s1, 12
    addi s2, s2, -1
    j loop_PintaPontos
fim_loop_PintaPontos:

    # Desaloca o vetor de pontos
    srli t0, s0, 3
    add sp, sp, t0

    # Recupera registadores utilizados da pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Encerra o programa
    li a0, 10
    ecall
    ret

# Funcao void LePonto(Ponto *p)
LePonto:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)

    # Guarda o ponteiro em s0
    mv s0, a0

    # Le a coordenada x e guarda na memoria
    call LeNumero
    sw a0, 0(s0)

    # Le a coordenada y e guarda na memoria
    call LeNumero
    sw a0, 4(s0)

    # Le a cor do ponto e guarda na memoria
    call LeNumero
    sw a0, 8(s0)

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
