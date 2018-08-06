pragma solidity ^0.4.24;

/**
 * 2. Implementation of a token smart contract 
 *   5. Start implementing ERC20 methods
 *     - mapping and its key and value
 *     - private
 *     - return value
 *     - view
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
     * Maps owner address to his balance
     */
    mapping(address => uint256) private balances;

    constructor(string _name, string _symbol, uint8 _decimals) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    /**
     * Required for ERC20.
     * Get the current balance of `owner`.
     */
    function balanceOf(address owner) public view returns (uint256) {
        return balances[owner];
    }
}
