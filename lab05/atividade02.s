.data
vetor: 
    .word 10
    .word 20
    .word 30
.text
main:
    # Armazena em s0 o endereco de vetor
    lui s0, %hi(vetor)
    addi s0, s0, %lo(vetor)

    # Le os numeros e soma eles
    lw s1, s0, 0
    lw s2, s0, 4
    lw s3, s0, 8

    # Incrementa os numeros
    addi s1, s1, 1
    addi s2, s2, 1
    addi s3, s3, 1

    # Le os numeros e soma eles
    sw s1, s0, 0
    sw s2, s0, 4
    sw s3, s0, 8

    # Armazena a soma em s4
    add s4, s1, s2
    add s4, s4, s3

    # Imprime a soma
    add a0, zero, s4
    addi t0, zero, 1
    ecall

    ret
