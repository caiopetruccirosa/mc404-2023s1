.data
vetor_operacoes:
    .byte 43 # caracter '+' na tabela ASCII
    .word 0
    .byte 45 # caracter '+' na tabela ASCII
    .word 0

.text
# Funcao Soma
# Retorna a soma de dois numero
# Parametros: numero a (em a0) e numero b (em a1)
# Retorno: o resultado da soma a+b (em a0)
Soma:
    add a0, a0, a1
    ret

# Funcao Subtracao
# Retorna a subtracao de dois numero
# Parametros: numero a (em a0) e numero b (em a1)
# Retorno: o resultado da subtracao a-b (em a0)
Subtracao:
    sub a0, a0, a1
    ret

main:
    ret