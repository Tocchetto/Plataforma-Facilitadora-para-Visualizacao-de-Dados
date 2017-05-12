;Testes Função Login:
;CT_001
UTAssert(login("Guilherme", "senha", 1) == 1)
;CT_002
UTAssert(login("Guilherme", "qualquercoisa", 1) == 0)
;CT_003
UTAssert(login("qualquercoisa", "qualquercoisa", 1) == 0)
;CT_004
UTAssert(login("qualquercoisa", "senha", 1) ==  2) ;É 2 porque vai dar o erro do tempo

;Teste função login mensagem de tempo:
;CT_005
UTAssert(login("qualquercoisa", "qualquercoisa", 1) == 0)
UTAssert(login("Guilherme", "qualquercoisa", 1) == 0)
UTAssert(login("qualquercoisa", "senha", 1) == 2)

;Teste Botão "Usuários":
;CT_006
UTAssert(FileExists("Data/allUsers.txt") == 1) ;Pré-Condição
UTAssert(listAllUsers(1) == 1) ;Testa se os usários são listados
;CT_007
FileMove("Data/allUsers.txt", "Data/allUsers2.txt") ;Troca o nome do arquivo para ele "deixar de existir" -> Pré-condição
UTAssert(listAllUsers(1) == 0) ;Chamar a fução "listAllUsers" simula o clicar no botão "Usuários"
FileMove("Data/allUsers2.txt", "Data/allUsers.txt") ;Troca o nome do arquivo para o nome original
;CT_008
FileCopy("Data/allUsers.txt", "Data/allUsersCopy.txt") ;Faz uma cópia do arquivo
FileWrite("Data/allUsers.txt", "Alteração") ;Pré-Condição
UTAssert(listAllUsers(1) == 1) ;Testa se os usários são listados
FileDelete("Data/allUsers.txt")
FileCopy("Data/allUsersCopy.txt", "Data/allUsers.txt")
FileDelete("Data/allUsersCopy.txt")

;Teste Botão "Usuários Assinantes"
;CT_009
UTAssert(FileExists("Data/paidUsers.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsers(1) == 1) ;Testa se os usários são listados
;CT_010
FileMove("Data/paidUsers.txt", "Data/paidUsers2.txt") ;Troca o nome do arquivo para ele "deixar de existir" -> Pré-condição
UTAssert(listPaidUsers(1) == 0) ;Chamar a fução "listPaidUsers" simula o clicar no botão "Usuários Assinantes"
FileMove("Data/paidUsers2.txt", "Data/paidUsers.txt") ;Troca o nome do arquivo para o nome original
;CT_011
FileCopy("Data/paidUsers.txt", "Data/paidUsersCopy.txt") ;Faz uma cópia do arquivo
FileWrite("Data/paidUsers.txt", "Alteração") ;Pré-Condição
UTAssert(listPaidUsers(1) == 1) ;Testa se os usários são listados
FileDelete("Data/paidUsers.txt")
FileCopy("Data/paidUsersCopy.txt", "Data/paidUsers.txt")
FileDelete("Data/paidUsersCopy.txt")

;Teste Botão "Usuários do Tipo1"
;CT_012
UTAssert(FileExists("Data/paidUsersType1.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsersType1(1) == 1) ;Testa se os usários são listados
;CT_013
FileMove("Data/paidUsersType1.txt", "Data/paidUsersType12.txt") ;Troca o nome do arquivo para ele "deixar de existir" -> Pré-condição
UTAssert(listPaidUsersType1(1) == 0) ;Chamar a fução "listPaidUsersType1" simula o clicar no botão "Usuários do Tipo 1"
FileMove("Data/paidUsersType12.txt", "Data/paidUsersType1.txt") ;Troca o nome do arquivo para o nome original
;CT_014
FileCopy("Data/paidUsersType1.txt", "Data/paidUsersType1Copy.txt") ;Faz uma cópia do arquivo
FileWrite("Data/paidUsersType1.txt", "Alteração") ;Pré-Condição
UTAssert(listPaidUsersType1(1) == 1) ;Testa se os usários são listados
FileDelete("Data/paidUsersType1.txt")
FileCopy("Data/paidUsersType1Copy.txt", "Data/paidUsersType1.txt")
FileDelete("Data/paidUsersType1Copy.txt")

;Teste Botão "Usuários do Tipo2"
;CT_015
UTAssert(FileExists("Data/paidUsersType2.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsersType2(1) == 1) ;Testa se os usários são listados
;CT_016
FileMove("Data/paidUsersType2.txt", "Data/paidUsersType22.txt") ;Troca o nome do arquivo para ele "deixar de existir" -> Pré-condição
UTAssert(listPaidUsersType2(1) == 0) ;Chamar a fução "listPaidUsersType2" simula o clicar no botão "Usuários do Tipo 2"
FileMove("Data/paidUsersType22.txt", "Data/paidUsersType2.txt") ;Troca o nome do arquivo para o nome original
;CT_017
FileCopy("Data/paidUsersType2.txt", "Data/paidUsersType2Copy.txt") ;Faz uma cópia do arquivo
FileWrite("Data/paidUsersType2.txt", "Alteração") ;Pré-Condição
UTAssert(listPaidUsersType2(1) == 1) ;Testa se os usários são listados
FileDelete("Data/paidUsersType2.txt")
FileCopy("Data/paidUsersType2Copy.txt", "Data/paidUsersType2.txt")
FileDelete("Data/paidUsersType2Copy.txt")

;Teste Gerar Arquivo Texto
;CT_018
UTAssert(FileExists("Data/allUsers.txt") == 1) ;Pré-Condição
UTAssert(listAllUsers(1) == 1) ;Pré-Condição (Testa se os usários estão listados na caixa de diálogo)
UTAssert(downloadGeneratedUsers(1,0 ) == 1) ;Faz o download do "allUsers.txt" na área de trabalho
UTAssert(FileExists("C:\Users\" & @UserName & "\Desktop\allUsers.txt") == 1) ;Testa se o arquivo foi realmente criado
FileDelete("C:\Users\" & @UserName & "\Desktop\allUsers.txt")

;CT_019
UTAssert(FileExists("Data/allUsers.txt") == 1) ;Pré-Condição
UTAssert(listAllUsers(1) == 1) ;Pré-Condição (Testa se os usários estão listados na caixa de diálogo)
UTAssert(downloadGeneratedUsers(1, 1) == 0) ;Simula o botão "Cancelar" do explorador de arquivos

;CT_020
UTAssert(FileExists("Data/paidUsers.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsers(1) == 1) ;Pré-Condição (Testa se os usários estão listados na caixa de diálogo)
UTAssert(downloadGeneratedUsers(1,0 ) == 1) ;Faz o download do "paidUsers.txt" na área de trabalho
UTAssert(FileExists("C:\Users\" & @UserName & "\Desktop\paidUsers.txt") == 1) ;Testa se o arquivo foi realmente criado
FileDelete("C:\Users\" & @UserName & "\Desktop\paidUsers.txt")

;CT_021
UTAssert(FileExists("Data/paidUsers.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsers(1) == 1) ;Pré-Condição (Testa se os usários estão listados na caixa de diálogo)
UTAssert(downloadGeneratedUsers(1, 1) == 0) ;Simula o botão "Cancelar" do explorador de arquivos

;CT_022
UTAssert(FileExists("Data/paidUsersType1.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsersType1(1) == 1) ;Pré-Condição (Testa se os usários estão listados na caixa de diálogo)
UTAssert(downloadGeneratedUsers(1,0 ) == 1) ;Faz o download do "paidUsersType1.txt" na área de trabalho
UTAssert(FileExists("C:\Users\" & @UserName & "\Desktop\paidUsersType1.txt") == 1) ;Testa se o arquivo foi realmente criado
FileDelete("C:\Users\" & @UserName & "\Desktop\paidUsersType1.txt")

;CT_023
UTAssert(FileExists("Data/paidUsersType1.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsersType1(1) == 1) ;Pré-Condição (Testa se os usários estão listados na caixa de diálogo)
UTAssert(downloadGeneratedUsers(1, 1) == 0) ;Simula o botão "Cancelar" do explorador de arquivos

;CT_024
UTAssert(FileExists("Data/paidUsersType2.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsersType2(1) == 1) ;Pré-Condição (Testa se os usários estão listados na caixa de diálogo)
UTAssert(downloadGeneratedUsers(1,0 ) == 1) ;Faz o download do "paidUsersType2.txt" na área de trabalho
UTAssert(FileExists("C:\Users\" & @UserName & "\Desktop\paidUsersType2.txt") == 1) ;Testa se o arquivo foi realmente criado
FileDelete("C:\Users\" & @UserName & "\Desktop\paidUsersType2.txt")

;CT_025
UTAssert(FileExists("Data/paidUsersType2.txt") == 1) ;Pré-Condição
UTAssert(listPaidUsersType2(1) == 1) ;Pré-Condição (Testa se os usários estão listados na caixa de diálogo)
UTAssert(downloadGeneratedUsers(1, 1) == 0) ;Simula o botão "Cancelar" do explorador de arquivos
