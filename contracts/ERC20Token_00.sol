pragma solidity ^0.4.24;

contract HelloWorld {
    string public message;

    function setMessage(string _message) public {
        message = _message;
    }
}
