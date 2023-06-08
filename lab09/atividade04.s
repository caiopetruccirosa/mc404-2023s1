.text
main:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    # Le um numero N
    call LeNumero
    mv s1, a0

    # Aloca um vetor de N numeros na pilha
    slli t0, s1, 2
    sub sp, sp, t0
    mv s0, sp
    
    # Chama LeVetor
    mv a0, s0
    mv a1, s1
    call LeVetor

    # Calcula a media dos elementos no vetor
    mv a0, s0
    mv a1, s1
    call Media

    # Calcula o numero de elementos maiores que a media
    mv a2, a0
    mv a0, s0
    mv a1, s1
    call MaioresMedia

    # Imprime o numero de elementos maiores que a media
    # Valor a ser impresso ja esta em a0
    mv a1, a0
    li a0, 1
    ecall

    # Imprime caracter de nova linha '\n'
    li a0, 11
    li a1, 13
    ecall

    # Desaloca o vetor da pilha
    slli t0, s1, 2
    add sp, sp, t0

    # Recupera registadores utilizados da pilha
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8

    # Encerra o programa
    li a0, 10
    ecall

# Funcao int MaioresMedia(int *v, int N)
MaioresMedia:
    # Guarda o endereco do vetor, o numero de elementos, a media 
    # e o numero de elementos maiores que a media
    mv t0, a0
    mv t1, a1
    mv t2, a2
    mv t3, zero

loop_MaioresMedia:
    # Termina o loop
    beq t1, zero, fim_loop_MaioresMedia

    # Adiciona o numero atual na soma
    lw t4, 0(t0)

    # Se o numero nao for maior que a media, nao incrementa o contador
    bge t2, t4, nao_eh_maior
    addi t3, t3, 1 
nao_eh_maior:

    # Incrementa a posicao do vetor, diminui o contador e recomeca o loop
    addi t0, t0, 4
    addi t1, t1, -1
    j loop_MaioresMedia

fim_loop_MaioresMedia:
    # Define o retorno como o numero de elementos
    mv a0, t3
    ret

# Funcao int Media(int *v, int N)
Media:
    # Guarda o endereco do vetor, o numero de elementos e inicia a media
    mv t0, a0
    mv t1, a1
    mv t2, zero
    mv t3, a1
    
loop_Media:
    # Termina o loop
    beq t1, zero, fim_loop_Media

    # Adiciona o numero atual na soma
    lw t4, 0(t0)
    add t2, t2, t4

    # Incrementa a posicao do vetor, diminui o contador e recomeca o loop
    addi t0, t0, 4
    addi t1, t1, -1
    j loop_Media

fim_loop_Media:
    # Calcula a media e define como retorno
    div a0, t2, t3
    ret

# Funcao void LeVetor(int *v, int N)
LeVetor:
    # Armazena registadores utilizados na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)

    # Guarda o endereco do vetor em s0 e o numero N em s1
    mv s0, a0
    mv s1, a1

loop_LeVetor:
    bge zero, s1, fim_loop_LeVetor

    # Le o numero e adiciona no fim do vetor
    call LeNumero
    sw a0, 0(s0)

    # Incrementa a posicao do vetor, diminui o contador e recomeca o loop
    addi s0, s0, 4
    addi s1, s1, -1
    j loop_LeVetor

fim_loop_LeVetor:

    # Recupera registadores utilizados da pilha
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
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