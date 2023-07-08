total_conta = 0
total_saques = 0
LIM_DIARIO = 3
LIM_SAQUE = 500        

def deposito(valor_deposito, extrato):
    print("\n---------------------------------")
    print("\nREALIZANDO OPERAÇÃO DE DEPOSITO\n")
    global total_conta
    extrato.append(valor_deposito)
    total_conta += valor_deposito
    print("\nDEPOSITO REALIZADO COM SUCESSO!")
    print("\n---------------------------------")

def saque(valor_saque, extrato):
    global total_conta
    global total_saques
    print("\n---------------------------------")
    print("\nREALIZANDO OPERAÇÃO DE SAQUE\n")
    if(total_saques<LIM_DIARIO):
        if(valor_saque<=LIM_SAQUE):
            if(total_conta>=valor_saque):
                extrato.append(-(valor_saque))
                total_conta-=valor_saque
                total_saques+=1
                print("\nSAQUE REALIZADO COM SUCESSO!")
            else:
                print("\nNAO POSSIVEL REALIZAR O SAQUE!")
                print("\nVALOR DE SAQUE NAO DISPONIVEL NA CONTA, SEU SALDO É DE: ", total_conta)
        else:
            print("\nNAO POSSIVEL REALIZAR O SAQUE!")
            print("\nVALOR DE SAQUE TEM QUE SER INFERIOR A", LIM_SAQUE)
    else:
        print("\nNAO POSSIVEL REALIZAR O SAQUE!")
        print("\nJA ATINGIU O LIMITE DE", LIM_DIARIO, " SAQUES")
    print("\n---------------------------------")

def mostra_extrato(extrato):
    print("\n------------------------------------------------")
    print("\nEXTRATO:\n")
    global total_conta
    i=0
    j=1
    k=1
    while(i<len(extrato)):
        if(extrato[i]>=0):
            print(f"\nDEPÓSITO NÚMERO {j}: R$ {extrato[i]:.2f}")
            j+=1
        else:
            print(f"\nSAQUE NÚMERO {k}: R$ {extrato[i]:.2f}")
            k+=1
        i+=1
    print(f"\n\nSALDO ATUAL DA CONTA: R$ {total_conta:.2f}")
    print("\n------------------------------------------------")


def main():
    opcao="d"
    extrato = []
    while(opcao!="Q"):
        print("\n\n#####################")
        print("MENU:\nOPCAO Q = SAIR\nOPCAO D = DEPOSITO\nOPCAO S = SAQUE\nOPCAO E = EXTRATO")
        print("#####################\n")
        opcao = input("Digite a opcao desejada:\n")
        opcao = opcao.upper()
        while(opcao!="Q" and opcao!="D" and opcao!="S" and opcao!="E"):
            print("opcao invalida")
            opcao = input("Digite a opcao desejada:\n")
            opcao = opcao.upper()


        if(opcao=="D"):
            valor_deposito = int(input("Digite o valor de deposito\n"))
            while(valor_deposito<=0):
                print("valor igual a 0 ou negativo nao permitido")
                valor_deposito = int(input("Digite o valor de deposito\n"))
            deposito(valor_deposito, extrato)
        elif(opcao=="S"):
            valor_saque = int(input("Digite o valor de saque\n"))
            while(valor_saque<=0):
                print("valor igual a 0 ou negativo nao permitido")
                valor_saque = int(input("Digite o valor de saque\n"))
            saque(valor_saque, extrato)
        elif(opcao=="E"):
            mostra_extrato(extrato)
        
main()