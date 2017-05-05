#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>
#include "UTAssert.au3"
#include "unitTesting.au3"

HotKeySet("{ESC}", "Terminate")

Func Terminate()
   Exit 1
EndFunc

GUILogin()
;GUIinterface()

Func GUILogin()
   $loginWindow = GUICreate("Login", 301, 201)
   $usernameInput = GUICtrlCreateInput("", 60, 56, 185, 21)
   $usernameLabel = GUICtrlCreateLabel("Username:", 60, 37, 55, 17)
   $passwordLabel= GUICtrlCreateLabel("Password:", 60, 88, 53, 17)
   $passwordInput = GUICtrlCreateInput("", 60, 107, 185, 21, $ES_PASSWORD)
   Global $loginButton = GUICtrlCreateButton("Login", 136, 168, 75, 25)
   $closeButton = GUICtrlCreateButton("Close", 216, 168, 75, 25)
   Global $conectionProgressBar = GuiCtrlCreateProgress(100,140,100,20)
   GUISetState(@SW_SHOW)
   Global $chance = 2
   Global $momentoErro
   Global $loginError = 0
   while 1
	  $nMsg = GUIGetMsg()
	  If _DateDiff('s', $momentoErro, _NowCalc()) > 5 And $loginError == 1 Then
		 GUICtrlSetState($loginButton, $GUI_ENABLE)
		 $loginError = 0
	  EndIf
	  Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit
		 Case $closeButton
			Exit
		 Case $loginButton
			Local $username = GUICtrlRead($usernameInput)
			Local $password = GUICtrlRead($passwordInput)
			if login($username, $password) Then
			   GUICtrlSetData($conectionProgressBar, 100)
			   Sleep(700)
			   MsgBox(1,"Sucesso", "Login efetuado com sucesso!", 1)
			   GUIDelete($loginWindow)
			   GUIinterface()
			Else
			   GUICtrlSetData($conectionProgressBar, 100)
			   Sleep(700)
			   if $chance <> 0 Then
				  MsgBox(1, "Erro", "Usuário ou senha incorretos, tente novamente! ");Você tem mais " & $chance & " chances...
			   Else
				  $loginError = 1
				  $chance = 3
				  MsgBox(1, "Multiplas Tentativas Erradas", "Aguarde 10 segundos e tente novamente")
				  GUICtrlSetState($loginButton, $GUI_DISABLE)
				  $momentoErro = _NowCalc()
			   EndIf
			   $chance = $chance - 1
			   GUICtrlSetData($conectionProgressBar, 0)
			EndIf
	  EndSwitch
   WEnd
EndFunc

While 1
   Sleep(50)
WEnd

Func login($username, $password)
   If ($username == "Guilherme" And $password == "senha") Then
	  Return 1
   Else
	  Return 0
   EndIf
EndFunc

Func GUIinterface()
   $Interface = GUICreate("Consulta de Usuários", 487, 341)
   $allUsersButton = GUICtrlCreateButton("Usuários", 22, 16, 147, 25)
   $paidUsersButton = GUICtrlCreateButton("Usuários Assinantes", 22, 80, 147, 25)
   $type1UsersButton = GUICtrlCreateButton("Usuários do Tipo 1", 318, 16, 147, 25)
   $type2UsersButton = GUICtrlCreateButton("Usuários do Tipo 2", 318, 80, 147, 25)
   $generateFileButton = GUICtrlCreateButton("Gerar Arquivo Texto", 358, 304, 107, 25)
   Global $generatedData = GUICtrlCreateList("", 23, 120, 441, 175)
   GUISetState(@SW_SHOW)
   GUICtrlSetState($generateFileButton, $GUI_DISABLE)
   MsgBox(0, "Bem-Vindo", "Bem-Vindo ao sistema de consultas!",1)

   Global $currentListedFile = 0

   while 1
	  $nMsg = GUIGetMsg()

	  Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit
		 Case $allUsersButton
			If listAllUsers() Then
			   GUICtrlSetState($generateFileButton, $GUI_ENABLE)
			Else
			   MsgBox(0, "", "Arquivo com com a relação de todos os usuários não existe.")
			   GUICtrlSetState($generateFileButton, $GUI_DISABLE)
			EndIf
		 Case $paidUsersButton
			If listPaidUsers() Then
			   GUICtrlSetState($generateFileButton, $GUI_ENABLE)
			Else
			   MsgBox(0, "", "Arquivo com com a relação dos usuários assinantes não existe.")
			   GUICtrlSetState($generateFileButton, $GUI_DISABLE)
			EndIf
		 Case $type1UsersButton
			If listPaidUsersType1() Then
			   GUICtrlSetState($generateFileButton, $GUI_ENABLE)
			Else
			   MsgBox(0, "", "Arquivo com com a relação dos usuários do tipo1 não existe.")
			   GUICtrlSetState($generateFileButton, $GUI_DISABLE)
			EndIf
		 Case $type2UsersButton
			If listPaidUsersType2() Then
			   GUICtrlSetState($generateFileButton, $GUI_ENABLE)
			Else
			   MsgBox(0, "", "Arquivo com com a relação dos usuários do tipo2 não existe.")
			   GUICtrlSetState($generateFileButton, $GUI_DISABLE)
			EndIf
		 Case $generateFileButton
			If $currentListedFile == 0 Then
			   MsgBox(0,"Ação Inválida", "Por Favor, consulto um tipo de usuário para poder gerar um arquivo...")
			Else
			   downloadGeneratedUsers()
			EndIf
	  EndSwitch
   WEnd

EndFunc

Func listAllUsers()
   If FileExists("data\allUsers.txt") Then
	  $currentListedFile = 1
	  GUICtrlSetData($generatedData, "")
	  Local $lineAux = 1
	  While FileReadLine("data\allUsers.txt",$lineAux) <> ""
		 GUICtrlSetData($generatedData, FileReadLine("data\allUsers.txt",$lineAux))
		 $lineAux = $lineAux + 1
	  WEnd
	  Return True
   Else
	  GUICtrlSetData($generatedData, "")
	  Return False
   EndIf
EndFunc

Func listPaidUsers()
   If FileExists("data\paidUsers.txt") Then
	  $currentListedFile = 2
	  GUICtrlSetData($generatedData, "")
	  Local $lineAux = 1
	  While FileReadLine("data\paidUsers.txt",$lineAux) <> ""
		 GUICtrlSetData($generatedData, FileReadLine("data\paidUsers.txt",$lineAux))
		 $lineAux = $lineAux + 1
	  WEnd
	  Return True
   Else
	  GUICtrlSetData($generatedData, "")
	  Return False
   EndIf
EndFunc

Func listPaidUsersType1()
   If FileExists("data\paidUsersType1.txt") Then
	  $currentListedFile = 3
	  GUICtrlSetData($generatedData, "")
	  Local $lineAux = 1
	  While FileReadLine("data\paidUsersType1.txt",$lineAux) <> ""
		 GUICtrlSetData($generatedData, FileReadLine("data\paidUsersType1.txt",$lineAux))
		 $lineAux = $lineAux + 1
	  WEnd
	  Return True
   Else
	  GUICtrlSetData($generatedData, "")
	  Return False
   EndIf
EndFunc

Func listPaidUsersType2()
   If FileExists("data\paidUsersType2.txt") Then
	  $currentListedFile = 4
	  GUICtrlSetData($generatedData, "")
	  Local $lineAux = 1
	  While FileReadLine("data\paidUsersType2.txt",$lineAux) <> ""
		 GUICtrlSetData($generatedData, FileReadLine("data\paidUsersType2.txt",$lineAux))
		 $lineAux = $lineAux + 1
	  WEnd
	  Return True
   Else
	  GUICtrlSetData($generatedData, "")
	  Return False
   EndIf
EndFunc

Func downloadGeneratedUsers()
   ; Create a constant variable in Local scope of the message to display in FileSelectFolder.
   Local Const $sMessage = "Select a folder"

   ;MsgBox(1,"",@ScriptDir&"\data") Mostra o caminho que o script se encontra executando

   ; Display an open dialog to select a file.
   Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
   If @error Then
      ; Display the error message.
      MsgBox(0, "", "Nenhuma pasta foi selecionada")
   Else
	  If $currentListedFile == 1 Then
		 FileCopy(@ScriptDir&"\data\allUsers.txt", $sFileSelectFolder)
	  ElseIf $currentListedFile == 2 Then
		 FileCopy(@ScriptDir&"\data\paidUsers.txt", $sFileSelectFolder)
	  ElseIf $currentListedFile == 3 Then
		 FileCopy(@ScriptDir&"\data\paidUsersType1.txt", $sFileSelectFolder)
	  Else
		 FileCopy(@ScriptDir&"\data\paidUsersType2.txt", $sFileSelectFolder)
	  EndIf
	  MsgBox(0,"Sucesso", "Arquivo salvo em " & @CRLF & $sFileSelectFolder)
   EndIf
EndFunc
