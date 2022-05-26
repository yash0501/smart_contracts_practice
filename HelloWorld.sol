// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hello {
    string hello;

    function setHello(string memory _str) public {
        hello = _str;
    }

    function getHello() public view returns (string memory) {
        return hello;
    }
}
