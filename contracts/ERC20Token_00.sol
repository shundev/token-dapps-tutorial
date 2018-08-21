pragma solidity ^0.4.24;

contract ERC20Token {
    string public message;

    function setName(string _message) public {
        message = _message;
    }
}
