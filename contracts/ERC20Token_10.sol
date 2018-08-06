pragma solidity ^0.4.24;

/**
 * 2. Implementation of a token smart contract 
 *   10. Security
 *     - Overflow and underflow
 *     - Library
 *     - using/for
 */

/**
 * Overflow / Underflow safe math
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a * b;
        require(c / a == b, "Overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "Underflow");
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        require(c >= a, "Overflow");
        return c;
    }
}


contract ERC20Token {
    // Add SafeMath functions to uint256.
    using SafeMath for uint256;

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
     * Emitted when the ownership of token is transfered.
     * Events are filtered by the indexed fields (from, to).
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * Maps owner address to his balance
     */
    mapping(address => uint256) private balances;

    constructor(string _name, string _symbol, uint8 _decimals, uint256 _initialSupply) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply_ = _initialSupply;

        // Transfer all the tokens to msg.sender. It's YOU.
        balances[msg.sender] = totalSupply_;
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

    /**
     * Required for ERC20.
     * Transfers token in the amount of `value` from "me"(`msg.sender`) to address `to`.
     * `msg.sender` is the caller of a function.
     */
    function transfer(address to, uint256 value) public returns (bool) {
        require(value <= balances[msg.sender], "You don't have enough balance to transfer.");
        require(to != address(0), "You can't to transfer to 0x0. Please specify the recipient address `to`.");

        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[to] = balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }
}
