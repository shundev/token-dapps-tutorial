pragma solidity ^0.4.24;

/**
 * 2. Implementation of a token smart contract 
 *   6. Total Supply
 */

contract ERC20Token {
    /**
     * Token name
     */
    string public name;

    /**
     * Token symbol like BTC, ETH and so on.
     */
    string public symbol;

    /**
     * How many digits next to '.'
     * If decimals is 0, 1000 token is displayed as 1000.
     * If 3, 1000 token is displayed as 1.000.
     * Use 18, same decimals as ETH, if you don't have a paticular reason.
     */
    uint8 public decimals;

    /**
     * How many tokens you supply.
     */
    uint256 private totalSupply_;

    /**
     * Maps owner address to his balance
     */
    mapping(address => uint256) balances;

    constructor(string _name, string _symbol, uint8 _decimals, uint256 _initialSupply) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply_ = _initialSupply;
    }

    /**
     * Required for ERC20.
     * See totalSupply_ for understanding what it stands for.
     */
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    /**
     * Required for ERC20.
     * Get the current balance of `owner`.
     */
    function balanceOf(address owner) public view returns (uint256) {
        return balances[owner];
    }
}
