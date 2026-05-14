// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {

    mapping(address => uint256) private balances;

    // Deposit Ether
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    // Withdraw in Ether (Input 1 for 1 Full Ether)
    function withdraw(uint256 amountInEther) public {
        uint256 amount = amountInEther * 1 ether;

        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Effect: Update balance before sending (Prevents Reentrancy)
        balances[msg.sender] -= amount;

        // Interaction: Use .call instead of .transfer
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed.");
    }

    // Check balance in full Ether units
    function checkBalance() public view returns(uint256) {
        return balances[msg.sender] / 1 ether;
    }
}



/*<!-- How to Perform in Practical
Step 1. Open Remix IDE

Step 2. Create File
SimpleBank.sol

Step 3. Compile

Step 4. Deploy

Step 5. Test Functions
    1. Deposit Money
        Enter value in VALUE field (example: 1 Ether)
        Click deposit

    2. Check Balance
        Click checkBalance
        It will show your deposited amount.

    3. Withdraw Money
        Enter amount in Wei
        Example:
        1 Ether=10^18 Wei

        For 1 Ether withdrawal:
        1000000000000000000
        withdraw 0


    4. Click withdraw -->*/
