.data
vetor_cores: .word 0x00F37254, 0x0093E0E3, 0x005D5D5A, 0x00F4D35E, 0x00A1A1A1, 0x003D3B8E, 0x008ECAE6, 0x00F72585, 0x004CAF50, 0x00F9C74F
.text
main:
    # Carrega o vetor de cores
    la s5, vetor_cores
    li s6, 10

    # Pinta o fundo de branco
    li a0, 0x101
    li a1, 0x00FFFFFF
    ecall

laco_cores:
    beq s6, zero, fim_laco_cores

    li s0, 0x00020000 # Coordenada x = 2

laco_maior:
    # Se passou do x = 7, termina o laco
    li t0, 0x00070000
    blt t0, s0, fim_laco_maior
    
    li s1, 0x00000002 # Coordenada y = 2
laco_menor:
    # Se passou do y = 4, termina o laco
    li t0, 0x00000007
    blt t0, s1, fim_laco_menor

    # Pinta o ponto (x,y)
    li a0, 0x100
    add a1, s0, s1
    lw a2, 0(s5)
    ecall

    # Incrementa a coordenada y e recomeca o laco
    li t0, 0x00000001
    add s1, s1, t0
    j laco_menor
fim_laco_menor:
    # Incrementa a coordenada x e recomeca o laco
    li t0, 0x00010000
    add s0, s0, t0
    j laco_maior
fim_laco_maior:
    # Adiciona nop para aumentar o tempo de execucao
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

    # Pinta o quadrado novamente com outra cor
    addi s5, s5, 4
    addi s6, s6, -1
    j laco_cores
fim_laco_cores:

    # Encerra o programa
    li a0, 10
    ecall