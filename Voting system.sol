// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {

    address public admin;
    bool public votingStarted;
    bool public votingEnded;

    constructor() {
        admin = msg.sender;
    }

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    uint public candidatesCount;

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    // Add candidate
    function addCandidate(string memory _name) public {
        require(msg.sender == admin, "Only admin can add candidates");
        candidatesCount++;

        candidates[candidatesCount] = Candidate(
            candidatesCount,
            _name,
            0
        );
    }

    // Start voting
    function startVoting() public {
        require(msg.sender == admin, "Only admin can start voting");
        votingStarted = true;
        votingEnded = false;
    }

    // End voting
    function endVoting() public {
        require(msg.sender == admin, "Only admin can end voting");
        votingEnded = true;
    }

    // Vote function
    function vote(uint _candidateId) public {

        require(votingStarted == true, "Voting has not started");
        require(votingEnded == false, "Voting has ended");
        require(hasVoted[msg.sender] == false, "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        hasVoted[msg.sender] = true;

        candidates[_candidateId].voteCount++;
    }

    // Get winner
    function getWinner() public view returns(string memory) {

        require(votingEnded == true, "Voting is still ongoing");

        uint maxVotes = 0;
        string memory winner;

        for(uint i = 1; i <= candidatesCount; i++) {

            if(candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winner = candidates[i].name;
            }
        }

        return winner;
    }
}


<!-- STEPS:

Step 1: Open Remix

Step 2: Create Solidity File
    Voting.sol
    Paste the smart contract code.

Step 3: Compile Contract

Step 4: Start Ganache

Step 5: Connect MetaMask to Ganache

Step 6: Import Ganache Account

Step 7: Deploy Smart Contract

Step 8:Testing the Voting System

1. Add Candidates
    Call:
    addCandidate("Alice")

    Then:
    addCandidate("Bob")

2. Start Voting
    Call:
    startVoting()

3. Vote
    From different MetaMask accounts:
    vote(1) or vote(2)

4. Verify One Vote Rule
    Try voting again from same account.
    You will get error:
    You have already voted

5. End Voting
    Admin calls: endVoting()

6. Get Winner
    Call:
    getWinner()

7. Example output:
    Alice


VIVA QUESTIONS:

1. What is a smart contract?
A smart contract is a self-executing program stored on blockchain.

2. Why use blockchain for voting?
Because blockchain provides:
Transparency
Security
Immutability

3. What is msg.sender?
It stores the address of the user calling the function.

4. How is double voting prevented?
Using:
mapping(address => bool) hasVoted;

5. What is Remix?
Remix IDE is an online Solidity IDE for writing and deploying smart contracts. -->