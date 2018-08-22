pragma solidity ^0.4.24;

contract HelloWorld {
    string public message;

    function setName(string _message) public {
        message = _message;
    }
}
