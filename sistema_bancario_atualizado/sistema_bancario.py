total_contas = 1
MAX_SAQUE = 500
LIM_DIARIO = 3

def criar_usuario(dic, nome, data, cpf, endereco):
    print("\n\n-------------USUARIO-------------")
    print("CRIANDO USUARIO")
    dic[cpf] = dict({"nome":nome, "data":data, "endereco":endereco})
    print("\nUSUARIO CRIADO COM SUCESSO!!")
    print("---------------------------------")

def criar_conta(dic_contas, dic_extrato, cpf):
    print("\n\n---------------CONTA-------------")
    print("CRIANDO CONTA")
    global total_contas
    dic_contas[total_contas] = dict({"cpf":cpf, "valor":0, "total_saques":0})
    dic_extrato[total_contas] = []
    print("\nCONTA CRIADA COM SUCESSO!!")
    print(f"NÚMERO DA CONTA: {total_contas}")
    print("---------------------------------")
    total_contas+=1

def ver_cpf(cpf, dic):
    if(cpf in dic):
        return True
    else:
        return False

def saque(dic_contas, dic_extrato, num_conta, valor_saque):
    print("\n\n------------------SAQUE-----------")
    print("REALIZANDO OPERACAO DE SAQUE")
    if(dic_contas[num_conta]["valor"]>=valor_saque):
        if(dic_contas[num_conta]["total_saques"]<LIM_DIARIO):
            if(valor_saque<=MAX_SAQUE):
                dic_contas[num_conta]["valor"]-=valor_saque
                dic_extrato[num_conta].append(-(valor_saque))
                dic_contas[num_conta]["total_saques"]+=1
                print("\nSAQUE REALIZADO COM SUCESSO")
            else:
                print("\nNAO POSSIVEL REALIZAR SAQUE VALOR DO SAQUE ACIMA DE: ", MAX_SAQUE)
        else:
            print("\nNAO POSSIVEL REALIZAR SAQUE POIS JA EXCEDEU LIMITE DE SAQUES DIARIOS")
    else:
        print("\nVALOR DE SAQUE NAO DISPONIVEL NA CONTA")
    print("----------------------------------\n\n")

def deposito(dic_contas, dic_extrato, num_conta, valor_deposito):
    print("\n\n-------------DEPOSITO------------")
    print("REALIZANDO OPERACAO DE DEPÓSITO")
    dic_contas[num_conta]["valor"]+=valor_deposito
    dic_extrato[num_conta].append(valor_deposito)
    print("\nDEPÓSITO REALIZADO COM SUCESSO")
    print("---------------------------------\n\n")

def extrato(dic_extrato, dic_contas, dic_usuarios, num_conta):
    lista = dic_extrato[num_conta]
    cpf = dic_contas[num_conta]["cpf"]
    nome = dic_usuarios[cpf]["nome"]
    data = dic_usuarios[cpf]["data"]
    endereco = dic_usuarios[cpf]["endereco"]
    valor = dic_contas[num_conta]["valor"]
    print("\n\n------------EXTRATO--------------")
    print(f"EXTRATO PARA A CONTA {num_conta}\nNome cliente: {nome}\nData nascimento:{data}\nEndereço: {endereco}\n")
    for i in range(0, len(lista)):
        if(lista[i]<0):
            print(f"\nVALOR SAQUE R$: {lista[i]:.2f}")
        else:
            print(f"\nVALOR DEPOSITO R$: {lista[i]:.2f}")
    print(f"\n\nVALOR TOTAL NA CONTA: R$ {valor:.2f}")
    print("---------------------------------\n\n")

def ver_cpf_contas(dic_contas, cpf):
    lista = []
    for i in range(1, len(dic_contas)+1):
        if(dic_contas[i]["cpf"]==cpf):
            lista.append(i)
    return lista

def mostra_usuarios(dic_usuarios, dic_contas):
    print("\n\n-----------USUARIOS--------------")
    i=1
    for chave in dic_usuarios.keys():
        lista = ver_cpf_contas(dic_contas, chave)
        print(f"USUARIO {i}")
        nome = dic_usuarios[chave]["nome"]
        data = dic_usuarios[chave]["data"]
        endereco = dic_usuarios[chave]["endereco"]
        print(f"CPF: {chave}")
        print(f"NOME: {nome}")
        print(f"DATA DE NASCIMENTO: {data}")
        print(f"ENDERECO: {endereco}")
        for j in range(0, len(lista)):
            print(f"POSSUI A CONTA: {lista[j]}")
        if(i<len(dic_usuarios.keys())):
            print("\n\n")
        i+=1
    print("---------------------------------\n\n")

def criando_exemplos_manualmente(dic_usuarios, dic_contas, dic_extrato):
    global total_contas
    dic_usuarios[11111111111] = dict({"nome":"JORGE PEREIRA DA SILVA", "data":"25/01/1997", "endereco":"RUA - 12 - NAO SEI - SP"})
    dic_usuarios[22343223443] = dict({"nome":"ANA CLAUDIA DOS SANTOS", "data":"18/03/1999", "endereco":"RUA - 145 - SEI LA - RJ"})
    dic_usuarios[21344444411] = dict({"nome":"OTAVIO OSMAR", "data":"20/10/2000", "endereco":"AV - 111 - EXEMPLOOOOO - SP"})
    dic_usuarios[22332112344] = dict({"nome":"CLEBER LEMOS", "data":"10/05/2003", "endereco":"RUA - 190 - NAO SEI TAMBEM - SP"})
    dic_usuarios[12345678900] = dict({"nome":"HENRIQUE MANUEL", "data":"23/02/2001", "endereco":"PRACA - 244 - EXEMPLOS - SP"})
    dic_contas[total_contas] = dict({"cpf":11111111111, "valor":0, "total_saques":0})
    dic_extrato[total_contas] = []
    total_contas+=1
    dic_contas[total_contas] = dict({"cpf":22343223443, "valor":0, "total_saques":0})
    dic_extrato[total_contas] = []
    total_contas+=1
    dic_contas[total_contas] = dict({"cpf":21344444411, "valor":0, "total_saques":0})
    dic_extrato[total_contas] = []
    total_contas+=1
    dic_contas[total_contas] = dict({"cpf":11111111111, "valor":0, "total_saques":0})
    dic_extrato[total_contas] = []
    total_contas+=1
    dic_contas[total_contas] = dict({"cpf":21344444411, "valor":0, "total_saques":0})
    dic_extrato[total_contas] = []
    total_contas+=1
    dic_contas[total_contas] = dict({"cpf":12345678900, "valor":0, "total_saques":0})
    dic_extrato[total_contas] = []
    total_contas+=1

def menu():
    print("\n\n--------MENU--------")
    print("1- SAQUE")
    print("2- DEPÓSITO")
    print("3- VISUALIZA EXTRATO")
    print("0- SAIR DA CONTA")
    print("--------------------")

def menu1():
    print("\n--------MENU--------")
    print("1- ENTRAR NO BANCO")
    print("2- CADASTRAR USUARIO")
    print("3- CADASTRAR CONTA")
    print("4- MOSTRAR CONTAS CADASTRADAS")
    print("0- PARAR")
    print("--------------------")

def main():
    dic_usuarios = dict({})
    dic_contas = dict({})
    dic_extrato = dict({})
    criando_exemplos_manualmente(dic_usuarios, dic_contas, dic_extrato)

    opcao1 = 1
    while(opcao1!=0):
        menu1()
        opcao1 = int(input("Digite a sua opcao:\n"))
        while(opcao1!=0 and opcao1!=1 and opcao1!=2 and opcao1!=3 and opcao1!=4):
            print("OPCAO INVALIDA")
            opcao1 = int(input("Digite a sua opcao:\n"))

        if(opcao1==1):
            opcao = 1
            cpf = input("DIGITE O CPF DO USUARIO:\n")
            while((len(cpf)!=11)):
                print("CPF INVALIDO")
                cpf = input("DIGITE O CPF DO USUARIO:\n")
            print("\n\n")
            if(ver_cpf(int(cpf), dic_usuarios)):
                while(opcao!=0):
                    nome=dic_usuarios[int(cpf)]["nome"]
                    print(f"\n\nSEJA BEM VINDO {nome}")
                    menu()
                    opcao = int(input("Digite a sua opcao:\n"))
                    while(opcao!=0 and opcao!=1 and opcao!=2 and opcao!=3):
                        print("OPCAO INVALIDA")
                        opcao = int(input("Digite a sua opcao:\n"))

                    #FAZER SAQUE
                    if(opcao==1):
                        lista = ver_cpf_contas(dic_contas, int(cpf))
                        if(len(lista)!=0):
                            if(len(lista)>1):
                                for i in range(0, len(lista)):
                                    print("VOCE TEM A CONTA: ",lista[i])
                                num_conta = int(input("DIGITE A CONTA PARA FAZER SAQUE:\n"))
                                while(num_conta not in lista):
                                    print("CONTA INVALIDA!")
                                    num_conta = int(input("DIGITE A CONTA PARA FAZER SAQUE:\n"))
                            else:
                                num_conta = lista[0]
                                print("VOCE SO TEM A CONTA: ",num_conta)
                            valor_saque = float(input("DIGITE O VALOR PARA SAQUE:"))
                            while(valor_saque<=0):
                                print("VALOR INVALIDO!")
                                valor_saque = float(input("DIGITE O VALOR PARA SAQUE:"))
                            saque(dic_contas, dic_extrato, num_conta, valor_saque)
                        else:
                            print("VOCE NAO TEM NENHUMA CONTA CRIADA, CADASTRE UMA E TENTE NOVAMENTE!")
                    
                    #FAZER DEPÓSITO
                    elif(opcao==2):
                        lista = ver_cpf_contas(dic_contas, int(cpf))
                        if(len(lista)!=0):
                            if(len(lista)>1):
                                for i in range(0, len(lista)):
                                    print("VOCE TEM A CONTA: ",lista[i])
                                num_conta = int(input("DIGITE A CONTA PARA FAZER DEPOSITO:\n"))
                                while(num_conta not in lista):
                                    print("CONTA INVALIDA!")
                                    num_conta = int(input("DIGITE A CONTA PARA FAZER DEPOSITO:\n"))
                            else:
                                num_conta = lista[0]
                                print("VOCE SO TEM A CONTA: ",num_conta)
                            valor_deposito = float(input("DIGITE O VALOR PARA DEPOSITO:"))
                            while(valor_deposito<=0):
                                print("VALOR INVALIDO!")
                                valor_deposito = float(input("DIGITE O VALOR PARA DEPOSITO:"))
                            deposito(dic_contas, dic_extrato, num_conta, valor_deposito)
                        else:
                            print("VOCE NAO TEM NENHUMA CONTA CRIADA, CADASTRE UMA E TENTE NOVAMENTE!")
                    
                    #VER EXTRATO
                    elif(opcao==3):
                        lista = ver_cpf_contas(dic_contas, int(cpf))
                        if(len(lista)!=0):
                            if(len(lista)>1):
                                for i in range(0, len(lista)):
                                    print("VOCE TEM A CONTA: ",lista[i])
                                num_conta = int(input("DIGITE A CONTA PARA VER EXTRATO:\n"))
                                while(num_conta not in lista):
                                    print("CONTA INVALIDA!")
                                    num_conta = int(input("DIGITE A CONTA PARA VER EXTRATO:\n"))
                            else:
                                num_conta = lista[0]
                                print("VOCE SO TEM A CONTA: ",num_conta)
                            extrato(dic_extrato, dic_contas, dic_usuarios, num_conta)
                        else:
                            print("VOCE NAO TEM NENHUMA CONTA CRIADA, CADASTRE UMA E TENTE NOVAMENTE!")
            else:
                print("CPF NÃO CADASTRADO NO BANCO, CADASTRE O SEU USUÁRIO E TENTE NOVAMENTE!\n\n")

        #CADASTRAR USUARIO
        elif(opcao1==2):
            nome = input("DIGITE O NOME DO USUARIO:\n").upper()
            dia = input("DIGITE O DIA DE NASCIMENTO DO USUARIO:\n")
            while(int(dia)<0 or int(dia)>=31):
                print("DIA INVALIDO")
                dia = input("DIGITE O DIA DE NASCIMENTO DO USUARIO:\n")
            mes = input("DIGITE O MES DE NASCIMENTO DO USUARIO:\n")
            while(int(mes)<0 or int(mes)>=12):
                print("MES INVALIDO")
                mes = input("DIGITE O MES DE NASCIMENTO DO USUARIO:\n")
            ano = input("DIGITE O ANO DE NASCIMENTO DO USUARIO:\n")
            while(int(ano)<1923 or int(ano)>=2008):
                print("ANO INVALIDO")
                ano = input("DIGITE O ANO DE NASCIMENTO DO USUARIO:\n")
            cpf = input("DIGITE O CPF DO USUARIO:\n")
            while((len(cpf)!=11) or (int(cpf) in dic_usuarios)):
                print("CPF INVALIDO")
                cpf = input("DIGITE O CPF DO USUARIO:\n")
            print("INFORMACOES SOBRE O ENDERECO:")
            logradouro = input("DIGITE O LOGRADOURO:\n").upper()
            nro = input("DIGITE O NUMERO:\n").upper()
            while(not nro.isdigit()):
                print("NUMERO INVALIDO")
                nro = input("DIGITE O NUMERO:\n").upper()
            bairo = input("DIGITE O BAIRO DO USUARIO:\n").upper()
            cidade = input("DIGITE A CIDADE DO USUARIO OU SIGLA DO ESTADO:\n").upper()
            endereco = (logradouro+" - "+nro+" - "+bairo+" - "+cidade)
            data = (dia+"/"+mes+"/"+ano)
            criar_usuario(dic_usuarios, nome, data, int(cpf), endereco)
        
        #CADASTRAR CONTA
        elif(opcao1==3):
            cpf = input("DIGITE O CPF DO USUARIO:\n")
            while((len(cpf)!=11)):
                print("CPF INVALIDO")
                cpf = input("DIGITE O CPF DO USUARIO:\n")
            if(ver_cpf(int(cpf), dic_usuarios)):
                criar_conta(dic_contas, dic_extrato, int(cpf))
            else:
                print("CPF NAO CADASTRADO NO BANCO, CADASTRE E TENTE NOVAMENTE!")

        elif(opcao1==4):
            mostra_usuarios(dic_usuarios, dic_contas)

main()