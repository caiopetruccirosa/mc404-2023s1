.data
string1:
    .string "O produto dos numeros "
string2:
    .string " e "
string3:
    .string " eh: "
.text
main:
    # Carrega o endereco das strings
    la s1, string1
    la s2, string2
    la s3, string3

    # Armazena os valores a serem multiplicados
    li s4, 50
    li s5, 2

    # Imprime a saida
    li a0, 4
    mv a1, s1
    ecall

    li a0, 1
    mv a1, s4
    ecall

    li a0, 4
    mv a1, s2
    ecall

    li a0, 1
    mv a1, s5
    ecall

    li a0, 4
    mv a1, s3
    ecall

    li a0, 1
    mul a1, s4, s5
    ecall

    li a0, 11
    li a1, 10
    ecall

    # Encerra o programa
    li a0, 10
    ecall