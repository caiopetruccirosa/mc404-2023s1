main:
  addi s0, zero, 4096        # s0 = 0 + 4096
  addi s1, zero, 2048        # s1 = 0 + 2048
  add  s2, s1, s2           # s2 = s1 + s0 
  ret