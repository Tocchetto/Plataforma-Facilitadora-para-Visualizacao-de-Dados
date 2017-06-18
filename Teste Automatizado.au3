HotKeySet("{esc}", "Terminate")


Func Terminate()
   Exit 1
EndFunc

main()
Func main()
   If(ProcessExists("Plataforma Facilitadora para Visualização de Dados.exe")) <> 0 Then
	  WinActivate("Login")
	  MsgBox(0,"Teste de Automatizado Funcional - Teste Automatizado", 'Para parar o teste pressione a tecla "ESC" a qualquer momento.' & @CRLF & "Não mexa no mouse e nem no teclado durante a execução do teste!")
	  WinMove("Login", "", 0,0)
	  WinActivate("Login")
	  MouseClick("left", 74, 89)
	  Send("Guilherme")
	  MouseClick("left", 69, 140)
	  Send("senha")
	  MouseClick("left", 177, 205)
	  Sleep(4000)
	  If(WinExists("Consulta de Usuários")) Then
		 MsgBox(0,"Sucesso - Teste Automatizado", "Login efetuado com sucesso!", 2)
		 WinMove("Consulta de Usuários", "", 0,0)

		 If(FileExists("data/allUsers.txt")) Then
			MouseClick("left" , 98, 54)
			MsgBox(0,"Sucesso - Teste Automatizado", "Usuários mostrados com sucesso! " & $file ,2)
		 Else
			MouseClick("left" , 98, 54)
			Sleep(500)
			If(WinExists("Erro ao Listar Usuários")) Then
			   WinMove("Erro ao Listar Usuários", "", 0, 0)
			   Sleep(1000)
			   MouseClick("left", 290, 116)
			   MsgBox(0,"Sucesso - Teste Automatizado", "Usuários não exibidos com sucesso! " ,2)
			Else
			   MsgBox("Erro - Teste Automatizado", "Erro ao listar todos os usuários", 5)
			EndIf
		 EndIf

		 If(FileExists("data/paidUsers.txt")) Then
			MouseClick("left", 96, 118)
			MsgBox(0,"Sucesso - Teste Automatizado", "Usuários mostrados com sucesso! " & $file ,2)
		 Else
			MouseClick("left", 96, 118)
			Sleep(500)
			If(WinExists("Erro ao Listar Usuários Assinantes")) Then
			   WinMove("Erro ao Listar Usuários Assinantes", "", 0, 0)
			   Sleep(1000)
			   MouseClick("left", 290, 116)
			   MsgBox(0,"Sucesso - Teste Automatizado", "Usuários não exibidos com sucesso! " ,2)
			Else
			   MsgBox("Erro - Teste Automatizado", "Erro ao listar todos os usuários", 5)
			EndIf
		 EndIf

		 If(FileExists("data/paidUsersType1.txt")) Then
			MouseClick("left", 394, 56)
			MsgBox(0,"Sucesso - Teste Automatizado", "Usuários mostrados com sucesso! " & $file ,2)
		 Else
			MouseClick("left", 394, 56)
			Sleep(500)
			If(WinExists("Erro ao Listar Usuários do Tipo1")) Then
			   WinMove("Erro ao Listar Usuários do Tipo1", "", 0, 0)
			   Sleep(1000)
			   MouseClick("left", 290, 116)
			   MsgBox(0,"Sucesso - Teste Automatizado", "Usuários não exibidos com sucesso! " ,2)
			Else
			   MsgBox("Erro - Teste Automatizado", "Erro ao listar todos os usuários", 5)
			EndIf
		 EndIf

		 If(FileExists("data/paidUsersType2.txt")) Then
			MouseClick("left", 394, 119)
			MsgBox(0,"Sucesso - Teste Automatizado", "Usuários mostrados com sucesso! " & $file ,2)
		 Else
			MouseClick("left", 394, 119)
			Sleep(500)
			If(WinExists("Erro ao Listar Usuários do Tipo2")) Then
			   WinMove("Erro ao Listar Usuários do Tipo2", "", 0, 0)
			   Sleep(1000)
			   MouseClick("left", 290, 116)
			   MsgBox(0,"Sucesso - Teste Automatizado", "Usuários não exibidos com sucesso! " ,2)
			Else
			   MsgBox("Erro - Teste Automatizado", "Erro ao listar todos os usuários", 5)
			EndIf
		 EndIf

		 ;Teste se o arquivo foi salvo
#CS 		 MouseClick("left", 414, 343)
### 		 WinMove("Selecione uma Pasta", 0, 0, 800, 600)
### 		 MouseClick("left", 1011, 505)
### 		 MsgBox(0,"Sucesso - Teste Automatizado", "Arquivo salvo! - Fim do teste!")
 #CE
	  Else
		 MsgBox(48,"Erro - Teste Automatizado", "Erro ao realizar o login...", 5)
	  EndIf
   Else
	  MsgBox(0,"Erro - Teste Automatizado", 'O sistema "Plataforma Facilitadora para Visualização de Dados" deve estar aberto para que esse script funcionar.')
   EndIf
EndFunc