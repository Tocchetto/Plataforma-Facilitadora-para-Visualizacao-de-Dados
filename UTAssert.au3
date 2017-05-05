Func UTAssert(Const $bool, Const $msg = "Assert Failure", Const $erl = @ScriptLineNumber)
	If Not $bool Then
		ConsoleWrite("(" & $erl & ") := " & $msg & @LF)
	EndIf
	Return $bool
EndFunc