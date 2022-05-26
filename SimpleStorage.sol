// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint store;

    function setStore(uint _store) public {
        store = _store;
    }

    function getStore() public view returns (uint) {
        return store;
    }
}
