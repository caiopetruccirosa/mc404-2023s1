.rodata
vetor_pontos:
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0

.text
main:
    # Armazena em s0 o endereco de vetor_pontos
    lui s0, %hi(vetor_pontos)
    addi s0, s0, %lo(vetor_pontos)

    ret
