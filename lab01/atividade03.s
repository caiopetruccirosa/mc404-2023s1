main:
  addi t0, zero, 4   # escolhe a operacao de leitura de inteiro (4)
  ecall              # efetua a operacao de leitura de inteiro

  add  s0, zero, a0   # s0 = 0 + leitura
  add  s1, zero, s0   # s1 = 0 + s0
  addi s1, s1, 2      # s2 = s1 + 2

  ret