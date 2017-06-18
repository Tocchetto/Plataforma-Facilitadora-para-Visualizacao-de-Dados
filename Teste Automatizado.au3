HotKeySet("{esc}", "Terminate")


Func Terminate()
   Exit 1
EndFunc

main()
Func main()
   If(ProcessExists("Plataforma Facilitadora para Visualização de Dados.exe")) <> 0 Then
	  MsgBox(0,"Teste de Automatizado Funcional", 'Para parar o teste pressione a tecla "ESC" a qualquer momento.' & @CRLF & "Não mexa no mouse e nem no teclado durante a execução do teste!")
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
		 MouseClick("left" , 98, 54)
		 MsgBox(0,"Sucesso", "Usuários mostrados com sucesso!",2)
		 MouseClick("left", 96, 118)
		 MsgBox(0,"Sucesso", "Usuários Assinantes mostrados com sucesso!",2)
		 MouseClick("left", 394, 56)
		 MsgBox(0,"Sucesso", "Usuários do Tipo1 mostrados com sucesso!",2)
		 MouseClick("left", 394, 119)
		 MsgBox(0,"Sucesso", "Usuários do Tipo2 mostrados com sucesso!",2)
		 MouseClick("left", 414, 343)
		 WinMove("Selecione uma Pasta", 0, 0, 800, 600)
		 MouseClick("left", 1011, 505)
		 MsgBox(0,"Sucesso", "Arquivo salvo! - Fim do teste!")
	  Else
		 MsgBox(48,"Erro", "Erro ao realizar o login...")
	  EndIf
   Else
	  MsgBox(0,"Erro", 'O sistema "Plataforma Facilitadora para Visualização de Dados" deve estar aberto para que esse script funcionar.')
   EndIf
EndFunc