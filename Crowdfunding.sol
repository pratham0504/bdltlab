// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {

    struct Campaign {
        address payable creator;
        string title;
        uint goal;
        uint deadline;
        uint amountCollected;
        bool fundsWithdrawn;
    }

    uint public campaignCount;

    mapping(uint => Campaign) public campaigns;
    mapping(uint => mapping(address => uint)) public donations;

    // Create a new campaign
    function createCampaign(
        string memory _title,
        uint _goal,
        uint _durationInMinutes
    ) public {

        campaignCount++;

        campaigns[campaignCount] = Campaign({
            creator: payable(msg.sender),
            title: _title,
            goal: _goal,
            deadline: block.timestamp + (_durationInMinutes * 1 minutes),
            amountCollected: 0,
            fundsWithdrawn: false
        });
    }

    // Donate to campaign
    function donate(uint _campaignId) public payable {

        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp < campaign.deadline, "Campaign ended");
        require(msg.value > 0, "Send some ether");

        donations[_campaignId][msg.sender] += msg.value;
        campaign.amountCollected += msg.value;
    }

    // Withdraw funds by creator if goal reached
    function withdrawFunds(uint _campaignId) public {

        Campaign storage campaign = campaigns[_campaignId];

        require(msg.sender == campaign.creator, "Only creator can withdraw");
        require(block.timestamp >= campaign.deadline, "Campaign still active");
        require(campaign.amountCollected >= campaign.goal, "Goal not reached");
        require(!campaign.fundsWithdrawn, "Funds already withdrawn");

        campaign.fundsWithdrawn = true;

        campaign.creator.transfer(campaign.amountCollected);
    }

    // Refund donors if goal not reached
    function refund(uint _campaignId) public {

        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp >= campaign.deadline, "Campaign still active");
        require(campaign.amountCollected < campaign.goal, "Goal was reached");

        uint donatedAmount = donations[_campaignId][msg.sender];

        require(donatedAmount > 0, "No donation found");

        donations[_campaignId][msg.sender] = 0;

        payable(msg.sender).transfer(donatedAmount);
    }

    // View campaign details
    function getCampaign(uint _campaignId)
        public
        view
        returns (
            string memory,
            uint,
            uint,
            uint
        )
    {
        Campaign memory campaign = campaigns[_campaignId];

        return (
            campaign.title,
            campaign.goal,
            campaign.deadline,
            campaign.amountCollected
        );
    }
}



<!-- Steps to Perform in Remix IDE
1. Open Remix IDE

2. Create Solidity File
    Crowdfunding.sol
    Paste the above code.

3. Compile the Contract

4. Deploy the Contract

Practical Execution

Step 1: Create Campaign

    Input:
    _title = Help Students
    _goal = 5 ether
    _durationInMinutes = 5

    Click:
    createCampaign

    Transaction will be successful.

Step 2: Donate Ether

    Select another account in MetaMask
    Enter:
    campaignId = 1
    In VALUE field enter:
    1 ether
    Click: donate

    Repeat donations from multiple accounts.

Step 3A: Goal Achieved

    If total donations ≥ goal:
    Wait until deadline ends

    Creator account clicks:
    withdrawFunds(1)
    Funds transfer to creator.

Step 3B: Goal Not Achieved

    If donations < goal:
    After deadline

    Donor clicks:
    refund(1)
    Donor receives refund.


VIVA QUESTIONS:

1. What is crowdfunding in blockchain?
A decentralized method of raising funds using smart contracts.

2. Why use smart contracts for crowdfunding?
They provide transparency, automation, and security without intermediaries.

3. What is msg.sender?
Address of the user calling the function.

4. What is payable?
Allows a function or address to send/receive Ether.

5. What is block.timestamp?
Current block time used for deadlines.

6. Why is refund functionality important?
It protects donors if funding goals are not achieved. -->