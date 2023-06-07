.text
main:
    # Chama LeNumero
    call LeNumero

    # Imprime o numero lido
    mv a1, a0
    li a0, 1
    ecall

    # Encerra o programa
    li a0, 10
    ecall

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
    li    a0, 0x130
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