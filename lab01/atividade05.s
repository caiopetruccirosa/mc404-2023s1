main:
    addi t0, zero, 4    # escolhe a operacao de leitura de inteiro (4)
    ecall               # efetua a operacao de leitura de inteiro
    add  s0, zero, a0   # s0 = 0 + leitura0
    
    addi t0, zero, 4    # escolhe a operacao de leitura de inteiro (4)
    ecall               # efetua a operacao de leitura de inteiro
    add  s1, zero, a0   # s1 = 0 + leitura1

    add s2, s0, s1     # soma os valores

    add a0, zero, s2
    addi t0, zero, 1   # escolhe a operacao de escrita de inteiro (1)
    ecall              # efetua a operacao de escrita de inteiro

    ret