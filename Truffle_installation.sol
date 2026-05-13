Truffle Installation Steps


Requirements

Before installing Truffle, install the following:

Node.js
npm (Node Package Manager)

You can download Node.js from:

Node.js Official Website

Steps to Install Truffle
Step 1: Install Node.js
Download and install Node.js from the official website.
During installation, npm is installed automatically.
Verify Installation

Open Command Prompt / Terminal and type:

node -v

Check npm version:

npm -v

If version numbers appear, installation is successful.

Step 2: Install Truffle Globally

Open Command Prompt and run:

npm install -g truffle

This command installs Truffle globally on the system.

Step 3: Verify Truffle Installation

Run the command:

truffle version

If installed correctly, output will display:

Truffle version
Node version
Solidity compiler version

Example:

Truffle v5.x.x
Node v18.x.x
Step 4: Create a Truffle Project

Create a new folder:

mkdir MyProject

Move into the folder:

cd MyProject

Initialize Truffle project:

truffle init
Step 5: Project Structure Created

After initialization, the following folders are created:

Folder/File	Purpose
contracts	Stores smart contracts
migrations	Deployment scripts
test	Test files
truffle-config.js	Configuration file
Step 6: Compile Smart Contracts

Run:

truffle compile

This compiles Solidity smart contracts.

Step 7: Deploy Smart Contracts

Run:

truffle migrate

This deploys contracts to blockchain network.

Result

Truffle Framework was installed successfully and a new Truffle project was created.