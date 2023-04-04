.rodata
ro_vetor_1: 
    .word 10
    .word 20
    .word 30
    .word 40
    .word 50
ro_vetor_2:
    .word 10
    .word 15
    .word 20
    .word 25
    .word 30
    
.data
vetor_3:
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0

.text
main:
    # Armazena em s0 o endereco de ro_vetor_1
    lui s0, %hi(ro_vetor_1)
    addi s0, s0, %lo(ro_vetor_1)

    # Armazena em s1 o endereco de ro_vetor_2
    lui s1, %hi(ro_vetor_2)
    addi s1, s1, %lo(ro_vetor_2)

    # Armazena em s2 o endereco de vetor_3
    lui s2, %hi(vetor_3)
    addi s2, s2, %lo(vetor_3)

    # Armazena a soma do vetor_3 final em s11
    add s11, zero, zero

    # Inicia contador com 0 em s3 e limite em s10
    add s3, zero, zero
    addi s10, zero, 20
    
loop_soma:
    bge s3, s10, fim_loop_soma

    # Armazena a posicao de memoria do indice i do ro_vetor_1 em t0,
    # do ro_vetor_2 em t1 e do vetor_3 em t2
    add t0, s0, s3
    add t1, s1, s3
    add t2, s2, s3

    # Carrega os valores dos vetores de leitura em s4 e s5
    lw s4, t0, 0
    lw s5, t1, 0

    # Armazena a soma em s6
    add s6, s4, s5

    # Guarda a soma no vetor final
    sw s6, t2, 0

    # Adiciona a soma total
    add s11, s11, s6

    # Incrementa o contador e volta ao inicio do loop
    addi s3, s3, 4
    j loop_soma
fim_loop_soma:

    # Imprime a soma
    add a0, zero, s11
    addi t0, zero, 1
    ecall

    ret
