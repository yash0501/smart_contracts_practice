// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hello {
    string public hello;

    function setHello(string memory _str) public {
        hello = _str;
    }
}
