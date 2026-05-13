// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EscrowPayment {

    address public buyer;
    address payable public seller;
    address public arbiter;

    uint public amount;
    uint public releaseTime;

    bool public buyerApproved;
    bool public sellerApproved;
    bool public fundsReleased;
    bool public disputeRaised;

    constructor(address payable _seller, uint _durationInMinutes) payable {
        buyer = msg.sender;
        seller = _seller;
        arbiter = msg.sender;

        amount = msg.value;

        // Auto release time
        releaseTime = block.timestamp + (_durationInMinutes * 1 minutes);
    }

    // Buyer approves payment release
    function approveByBuyer() public {
        require(msg.sender == buyer, "Only buyer can approve");
        buyerApproved = true;

        releaseFunds();
    }

    // Seller approves completion
    function approveBySeller() public {
        require(msg.sender == seller, "Only seller can approve");
        sellerApproved = true;

        releaseFunds();
    }

    // Raise dispute before deadline
    function raiseDispute() public {
        require(
            msg.sender == buyer || msg.sender == seller,
            "Not authorized"
        );

        require(block.timestamp < releaseTime, "Time expired");

        disputeRaised = true;
    }

    // Internal function to release funds
    function releaseFunds() internal {

        require(!fundsReleased, "Funds already released");
        require(!disputeRaised, "Dispute exists");

        // Release if both approved
        if (buyerApproved && sellerApproved) {
            fundsReleased = true;
            seller.transfer(address(this).balance);
        }

        // Auto release after deadline
        else if (block.timestamp >= releaseTime) {
            fundsReleased = true;
            seller.transfer(address(this).balance);
        }
    }

    // Anyone can trigger auto release after deadline
    function autoRelease() public {
        releaseFunds();
    }

    // View contract balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}


<!-- How to Perform in Practical
Step 1. Open Remix IDE

Step 2. Create File
EscrowPayment.sol

Step 3. Compile

Step 4. Deploy

Step 5. Test Functions
1. Check Initial Details
    After deployment verify:
        buyer address
        seller address
        amount
        releaseTime
        balance

    Click:
        buyer()
        seller()
        getBalance()

2. Buyer Approval
    Using buyer account:

    Click:
    approveByBuyer()

    Now:
    buyerApproved = true

    But funds will NOT release yet because seller approval is pending.

3. Seller Approval
    Switch account in Remix to seller account.

    Click:
    approveBySeller()

    Now:
    both approvals become true
    Ether transfers to seller automatically

    Check:
    fundsReleased = true
    getBalance() = 0

4. Test Dispute System
    Deploy again.

    Before time expires:

    Click:
    raiseDispute()

    Now:
    disputeRaised = true

    If anyone tries:
    approveByBuyer()
    approveBySeller()
    autoRelease()

    transaction will fail because dispute exists.

5. Test Automatic Release After Time
    Deploy again with:
    1 minute
    Wait 1–2 minutes.

    Then click:
    autoRelease()

    Funds automatically transfer to seller if no dispute exists.

VIVA QUESTIONS:
Q1. What is escrow?
Escrow is a temporary holding mechanism where funds are stored securely until conditions are satisfied.

Q2. Why use smart contracts for escrow?
Because blockchain provides:
    transparency
    immutability
    automatic execution
    trustless transactions

Q3. What is block.timestamp?
It gives the current blockchain time in seconds.

Q4. Why use payable?
To allow the contract and seller address to receive Ether.

Q5. What happens if dispute is raised?
Funds remain locked until manual resolution (or additional logic is added).