// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 public storedData;

    // Function to update the value
    function set(uint256 x) public {
        storedData = x;
    }

    // Function to read the value
    function get() public view returns (uint256) {
        return storedData;
    }
}