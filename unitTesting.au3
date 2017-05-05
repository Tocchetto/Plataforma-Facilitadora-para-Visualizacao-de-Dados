;Testes Função Login
UTAssert(login("Guilherme", "senha") = 1)
UTAssert(login("Guilherme", "Senha") = 0)
UTAssert(login("Guilherme", "") = 0)
UTAssert(login("", "senha") = 0)
UTAssert(login("guilherme", "Senha") = 0)
UTAssert(login("guilherme", "senha") = 0)