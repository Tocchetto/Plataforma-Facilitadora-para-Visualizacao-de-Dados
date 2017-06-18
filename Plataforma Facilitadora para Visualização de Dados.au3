Global $conectionProgressBar
Global $chance = 2
Global $momentoErro
Global $loginError
Global $loginButton
Global $loginWindow
Global $generateFileButton
Global $currentListedFile = 0
Global $generatedData
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>
;Testes unitários:
;#include "UTAssert.au3"
;#include "unitTesting.au3"

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
   $loginButton = GUICtrlCreateButton("Login", 136, 168, 75, 25)
   $closeButton = GUICtrlCreateButton("Close", 216, 168, 75, 25)
   $conectionProgressBar = GuiCtrlCreateProgress(100,140,100,20)
   GUISetState(@SW_SHOW)
   $loginError = 0
   while 1
	  $nMsg = GUIGetMsg()
	  If _DateDiff('s', $momentoErro, _NowCalc()) > 9 And $loginError == 1 Then ; para dar 10 segundos
		 GUICtrlSetState($loginButton, $GUI_ENABLE)
		 $loginError = 0
	  EndIf
	  Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit
		 Case $closeButton
			Exit
		 Case $loginButton
		 	GUICtrlSetState($loginButton, $GUI_DISABLE)
			Local $username = GUICtrlRead($usernameInput)
			Local $password = GUICtrlRead($passwordInput)
			login($username, $password, 0)
	  EndSwitch
   WEnd
EndFunc

While 1
   Sleep(50)
WEnd

Func login($username, $password, $UT)
   If ($username == "Guilherme" And $password == "senha") Then
	  If $UT Then
		 Return 1
	  EndIf
	  GUICtrlSetData($conectionProgressBar, 100)
	  If Not $UT Then
		 Sleep(700)
	  EndIf
	  MsgBox(0,"Sucesso", "Login efetuado com sucesso!", 1)
	  GUIDelete($loginWindow)
	  If Not $UT Then
		 GUIinterface()
	  EndIf
	  Return 1
   Else
	  GUICtrlSetData($conectionProgressBar, 100)
	  If Not $UT Then
		 Sleep(700)
		 GUICtrlSetState($loginButton, $GUI_ENABLE)
	  EndIf
	  if $chance <> 0 Then
		 $chance = $chance - 1
		 If $UT Then
			Return 0
		 EndIf
		 MsgBox(0, "Erro", "Usuário ou senha incorretos, tente novamente! ");Você tem mais " & $chance & " chances...
	  Else
		 $loginError = 1
		 $chance = 2
		 If $UT Then
			Return 2
		 EndIf
		 MsgBox(0, "Multiplas Tentativas Erradas", "Aguarde 10 segundos e tente novamente")
		 GUICtrlSetState($loginButton, $GUI_DISABLE)
		 $momentoErro = _NowCalc()
	  EndIf
	  If $UT Then
		 Return 0
	  EndIf
	  GUICtrlSetData($conectionProgressBar, 0)
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
   $generatedData = GUICtrlCreateList("", 23, 120, 441, 175)
   GUISetState(@SW_SHOW)
   GUICtrlSetState($generateFileButton, $GUI_DISABLE)
   MsgBox(0, "Bem-Vindo", "Bem-Vindo ao sistema de consultas!",1)

   while 1
	  $nMsg = GUIGetMsg()

	  Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit
		 Case $allUsersButton
			listAllUsers(0)
		 Case $paidUsersButton
			listPaidUsers(0)
		 Case $type1UsersButton
			listPaidUsersType1(0)
		 Case $type2UsersButton
			listPaidUsersType2(0)
		 Case $generateFileButton
			downloadGeneratedUsers(0, 0)
	  EndSwitch
   WEnd

EndFunc

Func listAllUsers($UT)
   If FileExists("data\allUsers.txt") Then
	  GUICtrlSetState($generateFileButton, $GUI_ENABLE)
	  $currentListedFile = 1
	  If $UT Then
		 Return 1
	  EndIf
	  GUICtrlSetData($generatedData, "")
	  Local $lineAux = 1
	  While FileReadLine("data\allUsers.txt",$lineAux) <> ""
		 GUICtrlSetData($generatedData, FileReadLine("data\allUsers.txt",$lineAux))
		 $lineAux = $lineAux + 1
	  WEnd
	  Return 1
   Else
	  GUICtrlSetState($generateFileButton, $GUI_DISABLE)
	  If($UT) Then
		 Return 0
	  EndIf
	  MsgBox(0, "Erro ao Listar Usuários", "Arquivo com a relação de todos os usuários não existe.")
	  GUICtrlSetData($generatedData, "")
	  Return 0
   EndIf
EndFunc

Func listPaidUsers($UT)
   If FileExists("data\paidUsers.txt") Then
	  GUICtrlSetState($generateFileButton, $GUI_ENABLE)
	  $currentListedFile = 2
	  If $UT Then
		 Return 1
	  EndIf
	  GUICtrlSetData($generatedData, "")
	  Local $lineAux = 1
	  While FileReadLine("data\paidUsers.txt",$lineAux) <> ""
		 GUICtrlSetData($generatedData, FileReadLine("data\paidUsers.txt",$lineAux))
		 $lineAux = $lineAux + 1
	  WEnd
	  Return 1
   Else
	  GUICtrlSetState($generateFileButton, $GUI_DISABLE)
	  If($UT) Then
		 Return 0
	  EndIf
	  MsgBox(0, "Erro ao Listar Usuários Assinantes", "Arquivo com a relação dos usuários assinantes não existe.")
	  GUICtrlSetData($generatedData, "")
	  Return 0
   EndIf
EndFunc

Func listPaidUsersType1($UT)
   If FileExists("data\paidUsersType1.txt") Then
	  GUICtrlSetState($generateFileButton, $GUI_ENABLE)
	  $currentListedFile = 3
	  If $UT Then
		 Return 1
	  EndIf
	  GUICtrlSetData($generatedData, "")
	  Local $lineAux = 1
	  While FileReadLine("data\paidUsersType1.txt",$lineAux) <> ""
		 GUICtrlSetData($generatedData, FileReadLine("data\paidUsersType1.txt",$lineAux))
		 $lineAux = $lineAux + 1
	  WEnd
	  Return True
   Else
	  GUICtrlSetState($generateFileButton, $GUI_DISABLE)
	  If($UT) Then
		 Return 0
	  EndIf
	  MsgBox(0, "Erro ao Listar Usuários do Tipo1", "Arquivo com a relação dos usuários do tipo1 não existe.")
	  GUICtrlSetData($generatedData, "")
	  Return False
   EndIf
EndFunc

Func listPaidUsersType2($UT)
   If FileExists("data\paidUsersType2.txt") Then
	  GUICtrlSetState($generateFileButton, $GUI_ENABLE)
	  $currentListedFile = 4
	  If $UT Then
		 Return 1
	  EndIf
	  GUICtrlSetData($generatedData, "")
	  Local $lineAux = 1
	  While FileReadLine("data\paidUsersType2.txt",$lineAux) <> ""
		 GUICtrlSetData($generatedData, FileReadLine("data\paidUsersType2.txt",$lineAux))
		 $lineAux = $lineAux + 1
	  WEnd
	  Return True
   Else
	  GUICtrlSetState($generateFileButton, $GUI_DISABLE)
	  If($UT) Then
		 Return 0
	  EndIf
	  MsgBox(0, "Erro ao Listar Usuários do Tipo2", "Arquivo com a relação dos usuários do tipo2 não existe.")
	  GUICtrlSetData($generatedData, "")
	  Return False
   EndIf
EndFunc

Func downloadGeneratedUsers($UT, $aux)
   If $aux Then
	  SetError(1)
   EndIf
   If $currentListedFile == 0 Then
	  If $UT Then
		 Return 0
	  EndIf
	  MsgBox(0,"Ação Inválida", "Por Favor, consulte um tipo de usuário para poder gerar um arquivo...") ;Isso não está previsto na documentação por que na teoria NUNCA irá acontecer, é só um debug...
	  Return 0
   EndIf
   ;Título do explorador de arquivos.
   Local Const $sMessage = "Selecione uma Pasta"

   ;MsgBox(1,"",@ScriptDir&"\data") Mostra o caminho que o script se encontra executando

   Local $sFileSelectFolder
   If $UT Then
	  $sFileSelectFolder = "C:\Users\" & @UserName & "\Desktop"
   Else
	  $sFileSelectFolder = FileSelectFolder($sMessage, "") ;Display an open dialog to select a file.
   EndIf
   If @error Or @error == 01 Then
	  If $UT Then
		 Return 0
	  EndIf
      MsgBox(0, "", "Nenhuma pasta foi selecionada")
   Else
	  If $currentListedFile == 1 Then
		 FileCopy(@ScriptDir&"\data\allUsers.txt", $sFileSelectFolder)
		 If $UT Then
			Return 1
		 EndIf
	  ElseIf $currentListedFile == 2 Then
		 FileCopy(@ScriptDir&"\data\paidUsers.txt", $sFileSelectFolder)
		 If $UT Then
			Return 1
		 EndIf
	  ElseIf $currentListedFile == 3 Then
		 FileCopy(@ScriptDir&"\data\paidUsersType1.txt", $sFileSelectFolder)
		 If $UT Then
			Return 1
		 EndIf
	  Else
		 FileCopy(@ScriptDir&"\data\paidUsersType2.txt", $sFileSelectFolder)
		 If $UT Then
			Return 1
		 EndIf
	  EndIf
	  MsgBox(0,"Sucesso", "Arquivo salvo em " & @CRLF & $sFileSelectFolder)
   EndIf
EndFunc
