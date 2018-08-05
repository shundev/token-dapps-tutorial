pragma solidity ^0.4.24;

/**
 * The interface to be required to implement for ERC20.
 * https://theethereum.wiki/w/index.php/ERC20_Token_Standard
 */
contract ERC20Interface {

    /**
     * How much token in total.
     */
    function totalSupply() public view returns (uint256);

    /**
     * Get the balance of `owner`.
     */
    function balanceOf(address owner) public view returns (uint256);

    /**
     * Get the allowance of `owner` to `spender`.
     */
    function allowance(address owner, address spender) public view returns (uint256);

    /**
     * Transfer the ownership of token in the amount of `value` from "me" to `to`.
     */
    function transfer(address to, uint256 value) public returns (bool);

    /**
     * Approve to spend "my" token in the amount of `value` to `spender`.
     */
    function approve(address spender, uint256 value) public returns (bool);

    /**
     * Transfer the ownership ot the token in the amount of `value` from `from` to `to`.
     * You have to be allowed by `from` to call the function.
     */
    function transferFrom(address from, address to, uint256 value) public returns (bool);

    /**
     * Emitted when the ownership of token is transfered.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * Emitted when allowed to spend.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
