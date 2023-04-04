.data
string:
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
    .byte 32
.text
main:
    # Armazena em s0 o endereco de string
    lui s0, %hi(string)
    addi s0, s0, %lo(string)

    # Armazena em s1 o tamanho maximo de 20 caracteres
    addi s1, zero, 20

    # Le uma string de 20 caracteres do teclado
    add a0, zero, s0
    add a1, zero, s1
    addi t0, zero, 6
    ecall

    # Inicia um contador em s2 que vai ate o tamanho maximo da string
    # E armazena o tamanho digitado da string
    add s2, zero, zero

loop_contar_caracteres:
    bge s2, s1, fim_loop_contar_caracteres

    # Armazena a posicao de memoria do caracter i da string em t0
    add t0, s0, s2

    # Carrega o caracter e armazena em s4
    lb s4, t0, 0

    # Se o caracter for o caracter 32 (espaco) termina a contagem
    addi t0, zero, 32
    beq s4, t0, fim_loop_contar_caracteres

    # Caso contrario, incrementa o contador de caracteres digitados e volta ao inicio do loop
    addi s2, s2, 1
    j loop_contar_caracteres
fim_loop_contar_caracteres:

    # Imprime o contador de caracteres digitados
    add a0, zero, s2
    addi t0, zero, 1
    ecall

    ret
