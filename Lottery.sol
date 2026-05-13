
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {

    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    // Buy lottery ticket
    function enter() public payable {
        require(msg.value == 1 ether, "Ticket price is 1 ETH");
        players.push(msg.sender);
    }

    // Generate random number
    function random() private view returns(uint) {
        return uint(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao,
                    players.length
                )
            )
        );
    }

    // Pick winner
    function pickWinner() public {
        require(msg.sender == manager, "Only manager can pick winner");
        require(players.length > 0, "No players entered");

        uint index = random() % players.length;

        payable(players[index]).transfer(address(this).balance);

        players = new address[](0);
    }

    // View players
    function getPlayers() public view returns(address[] memory) {
        return players;
    }
}


<!-- How to Perform in Remix + MetaMask
1. Open Remix

2. Create File
Lottery.sol
Paste the code.

3. Compile

4. Connect MetaMask

5. Deploy Contract

6. Buy Lottery Tickets Using Different Accounts
    Account 1
    Select Account 1 in MetaMask
    In VALUE field enter:
    1
    and choose ether

    Click:
    enter

    Account 2
    Repeat same steps.

    Account 3
    Repeat same steps.

    Each account becomes a lottery participant.

7. Verify Players
    Click:
    getPlayers

    You will see all participant wallet addresses.

8. Pick Winner
    Switch back to manager account (deployer account).

    Click:
    pickWinner

    The contract:
        randomly selects winner
        transfers all ETH to winner
        resets player list

9. Verify Winner
    Check:
        MetaMask balance increase
        Contract balance becomes 0
        getPlayers() returns empty array
        How Fairness is Ensured

VIVA QUESTIONS:
1. Why payable is used?
To allow contract to receive ETH.

2. Why require is used?
To validate conditions like:
    correct ticket price
    only manager can pick winner
    Why randomness is not fully secure here?

3. Blockchain values like timestamp can sometimes be influenced slightly.
This is a basic educational lottery contract.

4. How to improve randomness?
Using:
    Chainlink VRF
    commit-reveal schemes
    oracle-based randomness -->