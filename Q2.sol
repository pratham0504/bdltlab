Simple Solidity Program and Deployment on Truffle Local Blockchain
Aim

To write, compile, and deploy a simple Solidity smart contract using Truffle on a local blockchain.

Requirements
Node.js
Truffle Framework
Ganache Local Blockchain
Step 1: Create Truffle Project

Open Command Prompt and run:

mkdir SimpleContract

Move into project folder:

cd SimpleContract

Initialize Truffle project:

truffle init
Step 2: Write Solidity Program

Open:

contracts

Create file:

SimpleStorage.sol

Write the following code:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {

    uint public data;

    function setData(uint x) public {
        data = x;
    }

    function getData() public view returns(uint) {
        return data;
    }
}
Step 3: Create Migration File

Open folder:

migrations

Create file:

2_deploy_contracts.js

Write:

const SimpleStorage = artifacts.require("SimpleStorage");

module.exports = function(deployer) {
    deployer.deploy(SimpleStorage);
};
Step 4: Configure Truffle

Open:

truffle-config.js

Ensure development network is:

networks: {
  development: {
    host: "127.0.0.1",
    port: 7545,
    network_id: "*"
  }
}
Step 5: Start Ganache
Open Ganache
Click Quickstart Workspace
Ensure RPC Server is:
HTTP://127.0.0.1:7545
Step 6: Compile Smart Contract

Run command:

truffle compile

Expected output:

Compiling your contracts...
Compilation successful
Step 7: Deploy Smart Contract

Run:

truffle migrate

Expected output:

Deploying 'SimpleStorage'
...
SimpleStorage deployed successfully
Step 8: Test Contract on Truffle Console

Run:

truffle console

Execute commands:

let instance = await SimpleStorage.deployed()

Store value:

await instance.setData(100)

Retrieve value:

let value = await instance.getData()

Display value:

value.toString()

Expected Output:

'100'
Result

The Solidity smart contract was successfully compiled and deployed on Truffle local blockchain using Ganache.