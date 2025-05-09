// ICO Cragcoins

pragma solidity ^0.4.11;

contract Cragcoins_ico {
    // Número máximo de moedas
    uint public max_Cragcoins = 1000000;

    // Cotação de Cragcoins para o dólar
    uint public usd_to_Cragcoins = 1000;

    // Total de Cragcoins compradas por investidores
    uint public total_Cragcoins_bought = 0;

    // Mapeamento de saldo
    mapping(address => uint) equity_Cragcoins;
    mapping(address => uint) equity_usd;

    // Verificando se o investidor pode comprar Cragcoins
    modifier can_buy_Cragcoins(uint usd_invested) {
        require(usd_invested * usd_to_Cragcoins + total_Cragcoins_bought <= max_Cragcoins);
        _;
    }

    // Retornar o valor do investimento em Cragcoins
    function equity_in_Cragcoins(address investor) external constant returns (uint) {
        return equity_Cragcoins[investor];
    }

    // Retornar o valor do investimento em dólar
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    // Compra de Cragcoins
    function buy_Cragcoins(address investor, uint usd_invested) external
    can_buy_Cragcoins(usd_invested) {
        uint Cragcoins_bought = usd_invested * usd_to_Cragcoins;
        equity_Cragcoins[investor] += Cragcoins_bought;
        equity_usd[investor] = equity_Cragcoins[investor] / usd_to_Cragcoins;
        total_Cragcoins_bought += Cragcoins_bought;
    }

    // Venda de Cragcoins
    function sell_Cragcoins(address investor, uint Cragcoins_sold) external {
        equity_Cragcoins[investor] -= Cragcoins_sold;
        equity_usd[investor] = equity_Cragcoins[investor] / usd_to_Cragcoins;
        total_Cragcoins_bought -= Cragcoins_sold;
    }
}
