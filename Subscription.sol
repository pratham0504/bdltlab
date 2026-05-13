// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SubscriptionService {

    address public owner;
    uint public subscriptionFee = 1 ether;
    uint public subscriptionDuration = 1 minutes;

    struct Subscriber {
        uint expiryTime;
        bool subscribed;
    }

    mapping(address => Subscriber) public subscribers;

    constructor() {
        owner = msg.sender;
    }

    // Subscribe to the service
    function subscribe() public payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee");

        subscribers[msg.sender] = Subscriber({
            expiryTime: block.timestamp + subscriptionDuration,
            subscribed: true
        });
    }

    // Check if subscription is active
    function isSubscriptionActive(address user) public view returns (bool) {
        if (
            subscribers[user].subscribed &&
            block.timestamp <= subscribers[user].expiryTime
        ) {
            return true;
        } else {
            return false;
        }
    }

    // Get remaining subscription time
    function getRemainingTime(address user) public view returns (uint) {
        if (block.timestamp >= subscribers[user].expiryTime) {
            return 0;
        }

        return subscribers[user].expiryTime - block.timestamp;
    }

    // Owner withdraws collected funds
    function withdrawFunds() public {
        require(msg.sender == owner, "Only owner can withdraw");

        payable(owner).transfer(address(this).balance);
    }
}

<!-- How to Perform in Practical
Step 1. Open Remix IDE

Step 2. Create File
SubscriptionService.sol

Step 3. Compile

Step 4. Deploy

Step 5. Test Functions
A. Subscribe to Service
    Under deployed contract:
    Function:
        subscribe

    Value:
        Enter:
        1 ether

    Then click transact.
    This activates subscription for 30 days.

B. Check Subscription Status
    Function:
    isSubscriptionActive
    Input your wallet address.

    Output:
    true

    Means subscription is active.

C. Check Remaining Time
    Function:
    getRemainingTime

    Input your address.

    Output:
    Time remaining in seconds.

D. Verify Automatic Expiry
    Then call:
    isSubscriptionActive

    Output becomes:
    false

    This shows automatic expiration after time period.

E. Withdraw Funds (Owner Only)
Call:
withdrawFunds

Only deployer account can withdraw collected ether.

VIVA QUESTIONS
1. What is a subscription smart contract?
A blockchain contract that grants temporary access after payment.

2. What is block.timestamp?
Current blockchain timestamp used for expiry calculation.

3. Why use mapping?
To store subscription details for each user address.

4. How is expiration handled?
By comparing current time with stored expiry time.

5. Who can withdraw funds?
Only the contract owner.