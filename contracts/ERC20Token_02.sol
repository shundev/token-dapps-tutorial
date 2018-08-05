pragma solidity^ 0.4.24;

/**
 * 2. Implementation of a token smart contract 
 *   2. Constructor
 */

// Every time you deploy a contract, a new ID (contract address) is assigned to it.
// So, no problem even if multiple contracts have the same name.
contract ERC20Token {

    // uint256 can hold 0 or a positive number.
    uint256 public balance;

    // You can specify the `_balance` when you deploy the contract.
    constructor (uint256 _balance) public {
        balance = _balance;
    }

    // You pass a number when you call this function.
    function setBalance(uint256 newBalance) public {
        // Assign newBalance to balance
        balance = newBalance;
    }
}