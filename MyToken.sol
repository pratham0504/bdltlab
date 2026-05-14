/*Design and Develop Cryptocurrency
 
🔹 PART A: Install and Configure MetaMask
Step 1: Install MetaMask
1.	Open Google Chrome
2.	Visit:
https://metamask.io
3.	Click Download
4.	Click Add to Chrome
5.	Click Add Extension
 
Step 2: Create Wallet
1.	Open MetaMask
2.	Click Create a Wallet
3.	Create password
4.	Save the 12-word Secret Recovery Phrase
5.	Complete setup
 
Step 3: Enable Sepolia Network
1.	Open MetaMask
2.	Click network dropdown at top
3.	Select:
Sepolia Test Network
If not visible:
●	Go to Settings → Advanced
●	Enable:
Show Test Networks

 
Step 4: Get Test ETH
1.	Copy MetaMask wallet address
2.	Open Sepolia Faucet website
3.	Paste address
4.	Request test ETH
5.	Wait for ETH to appear in wallet
 
🔹 PART B: Open Remix IDE
Step 5: Open Remix
Visit:
https://remix.ethereum.org

 
🔹 PART C: Create Cryptocurrency Smart Contract
Step 6: Create Solidity File
1.	Open contracts folder
2.	Click New File
3.	Create:
MyToken.sol

 
Step 7: Write Smart Contract Code*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyToken {

    string public name = "PurvaCoin";
    string public symbol = "PVC";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {

        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        return true;
    }
}
 
/*🔹 PART D: Compile Smart Contract
Step 8: Compile Contract
1.	Click Solidity Compiler
2.	Select compiler version:
0.8.20
3.	Click:
Compile MyToken.sol

✔ If no errors appear, compilation is successful.
 
🔹 PART E: Deploy Smart Contract
Step 9: Open Deploy Section
1.	Click:
Deploy & Run Transactions
 
Step 10: Select Environment
Under Environment choose:
Injected Provider - MetaMask

👉 MetaMask popup appears.
 
Step 11: Connect MetaMask
1.	Click: Next
2.	Click: Connect
3.	Ensure network is: Sepolia
 
Step 12: Enter Initial Supply
In constructor parameter field:
_initialSupply

Enter:
1000

 
Step 13: Deploy Contract
1.	Click:
Deploy
2.	MetaMask popup appears
3.	Click:
Confirm
✔ Contract deploys successfully.
 
🔹 PART F: Locate Deployed Contract
Step 14: Open Deployed Contract
1.	Scroll down to: Deployed Contracts
2.	You will see: MyToken at 0x.....
3.	Click arrow: ▶ to expand the contract.
 
🔹 PART G: Check Total Supply
Step 15: Check totalSupply
1.	Click: totalSupply
2.	Output: 1000
3.	✔ This indicates total tokens created.
 
🔹 PART H: Check Account Balance
Step 16: Copy Account 1 Address
1.	Open MetaMask
2.	Select: Account 1
3.	Copy wallet address
Step 17: Check balanceOf
1.	In Remix find: balanceOf
2.	Paste Account 1 address in: param0(address)
3.	Click: balanceOf
4.	Output: 1000
✔ This indicates Account 1 owns all tokens.
 
🔹 PART I: Create Second Account
Step 18: Create Account 2
1.	Open MetaMask
2.	Click account icon
3.	Click: Add Account / Create Account
4.	Account 2 is created
 
🔹 PART J: Transfer Cryptocurrency
Step 19: Copy Account 2 Address
1.	Open MetaMask
2.	Select: Account 2
3.	Copy Account 2 address
 
Step 20: Transfer Tokens
1.	In Remix locate:
transfer(address _to, uint256 _value)
2.	In _to Paste:  Account 2 address
3.	In _value Enter: 100
4.	Click: transfer
5.	MetaMask popup appears
6.	Click: Confirm
✔ Transfer successful.
 
🔹 PART K: Verify Updated Balances
Step 21: Check Account 1 Balance
1.	Paste Account 1 address in balanceOf
2.	Click button
Output:
900
 
Step 22: Check Account 2 Balance
1.	Paste Account 2 address
2.	Click balanceOf
Output: 100
✔ Transfer verified successfully.
📊 OUTPUT
totalSupply = 1000

Account 1 balance = 1000

After transfer:
Account 1 balance = 900
Account 2 balance = 100
*/
 


