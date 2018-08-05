pragma solidity^ 0.4.24;

/**
 * 2. Implementation of a token smart contract 
 *   3. address and msg
 */

contract ERC20Token {
    uint256 public balance;

    // address can hold a Ethereum address such as 0x091225B0D977922de7483e65e24bb9d17dF687EC
    // Who set the balance last?
    address public who;

    constructor (uint256 _balance) public {
        balance = _balance;

        // msg.sender is the address of the creator of the contract.
        who = msg.sender;
    }

    function setBalance(uint256 newBalance) public {
        balance = newBalance;

        // msg.sender is the address of the caller of the function.
        who = msg.sender;
    }
}