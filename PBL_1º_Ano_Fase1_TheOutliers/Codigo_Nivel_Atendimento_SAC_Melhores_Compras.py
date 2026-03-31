# O trecho from sys import exit no seu código é usado pra encerrar imediatamente o programa caso a validação falhe
from sys import exit

numero = input("INSIRA SEU RM (ex: RM123456): ")
print(f"SEU RM É: \033[1;34m{'*' * 5}\033[m\033[1;31m{numero}\033[m\033[1;34m{'*' * 5}\033[m")

# Verificar se o RM tem 8 caracteres
if len(numero) != 8:
    print(f"\033[1;31mRM INVÁLIDO! Deve conter exatamente 8 caracteres, SEM espaço, sendo \"RM\" mais seis números (ex: RM123456).\033[m")
    exit()

# Verificar se os 2 primeiros são letras e os 6 últimos são números
letras = numero[:2]
numeros = numero[2:]

if not (letras.isalpha() and numeros.isdigit()):
    print(f"\033[1;31mRM INVÁLIDO! Os 2 primeiros caracteres devem ser letras e os 6 últimos, números (ex: RM123456).\033[m")
    exit()

print(f"\033[1;32mRM VÁLIDO! Participação autorizada, aluno de {numero}.\033[m")

idade = input("Insira a sua idade: ")
if int(idade) >= 18:
    print("Sua participação foi autorizada, aluno de rm{}.".format(numero))
    nota = int(input("De acordo com o seu índice de satisfação, avalie-nos em uma escala de 0 a 100: "))

    if nota >= 90:
        print("✅ Atendimento de qualidade!")
    elif 70 <= nota <= 89:
        print("😐 Atendimento neutro.")
    else:
        print("❌ Atendimento insatisfatório.")

    print("Mais informações serão enviadas para o e-mail cadastrado ! ")