SET @clientName := "JOAQUIN FONTANA";
SET @result := false;

CALL addSell(
	@clientName,
    7777.77,
    "2023.05.21",
    2.0,
    "Boleto",
    "2023.06.21",
    @result);

SELECT IF(@result = 1, "Vendas Adicionadas Com Sucesso", "Erro ao Adicionar Vendas: Cliente Não Cadastrado")