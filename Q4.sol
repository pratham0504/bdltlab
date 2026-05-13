<!-- STEP 1 — Open Remix IDE
    Go to:
    Remix IDE
    Create a file: SimpleStorage.sol

STEP 2 — Write Smart Contract -->

    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract SimpleStorage {

        uint public data;

        function setData(uint _data) public {
            data = _data;
        }

        function getData() public view returns(uint) {
            return data;
        }
    }

<!-- STEP 3 — Compile Contract

STEP 4 — Deploy Contract

STEP 5 — Confirm Transaction

STEP 6 — Interact with Contract

    Now Remix shows functions:
    setData
    getData

    Calling setData()
    Example: setData(50)



VIVA QUESTIONS

Q1. Why is gas required?
To pay for computational resources.

Q2. Difference between view and pure?
Type	Reads State	Modifies State
view	Yes	No
pure	No	No

Q3. Why MetaMask is used?
To:
Manage accounts
Sign transactions
Connect DApps to blockchain

Q4. What is ABI?
Interface describing smart contract functions.

Q5. What is bytecode?
Compiled machine code executed by EVM.

Q6. Why Ganache is used?
Provides local testing blockchain with fake ETH. -->