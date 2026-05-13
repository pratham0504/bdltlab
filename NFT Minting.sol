// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
NFT Minting Contract
Features:
1. Mint NFTs
2. Transfer NFTs
3. Store metadata URI for each NFT
4. Track ownership
*/

contract NFTMinting {

    // NFT structure
    struct NFT {
        uint256 tokenId;
        string metadataURI;
        address owner;
    }

    // Token counter
    uint256 public nextTokenId = 1;

    // tokenId => NFT
    mapping(uint256 => NFT) public nfts;

    // owner => list of token IDs
    mapping(address => uint256[]) public ownerTokens;

    // Mint NFT
    function mintNFT(string memory _metadataURI) public {

        uint256 tokenId = nextTokenId;

        nfts[tokenId] = NFT({
            tokenId: tokenId,
            metadataURI: _metadataURI,
            owner: msg.sender
        });

        ownerTokens[msg.sender].push(tokenId);

        nextTokenId++;
    }

    // Transfer NFT
    function transferNFT(address _to, uint256 _tokenId) public {

        require(nfts[_tokenId].owner == msg.sender,
            "You are not the owner");

        address previousOwner = msg.sender;

        // Change ownership
        nfts[_tokenId].owner = _to;

        // Add token to new owner
        ownerTokens[_to].push(_tokenId);

        // Remove token from previous owner
        removeToken(previousOwner, _tokenId);
    }

    // Internal function to remove token
    function removeToken(address _owner, uint256 _tokenId) internal {

        uint256[] storage tokens = ownerTokens[_owner];

        for(uint i = 0; i < tokens.length; i++) {

            if(tokens[i] == _tokenId) {

                tokens[i] = tokens[tokens.length - 1];
                tokens.pop();
                break;
            }
        }
    }

    // View NFT details
    function getNFT(uint256 _tokenId)
        public
        view
        returns(uint256, string memory, address)
    {

        NFT memory nft = nfts[_tokenId];

        return (
            nft.tokenId,
            nft.metadataURI,
            nft.owner
        );
    }

    // Get all NFTs owned by user
    function getMyNFTs()
        public
        view
        returns(uint256[] memory)
    {

        return ownerTokens[msg.sender];
    }
}

<!-- How to Perform in Practical
Step 1. Open Remix IDE

Step 2. Create File
NFTMinting.sol

Step 3. Compile

Step 4. Deploy

Step 5. Test Functions
1: Mint NFT
    Under deployed contract:
    Function:
    mintNFT

    Input example:
    https://mynftsite.com/metadata/nft1.json
    Click transact.

    Result:
    NFT created
    Owner = your account
    Token ID = 1

2: Check NFT Details
    Use:
    getNFT(1)

    Output:
    tokenId = 1
    metadata URI
    owner address

3: Check Your NFTs
    Call:
    getMyNFTs()

    Output:
    [1]

    Meaning:
    You own NFT #1.

4: Transfer NFT
    Change Account
    In Remix/MetaMask keep another account ready.

    Call:
    transferNFT

    Inputs:
    _to = second account address
    _tokenId = 1

    Click transact.
    NFT ownership transfers.

5: Verify Transfer
    Call:
    getNFT(1)

    Owner address will now be the second account.
    Also switch to second account and call:

    getMyNFTs()

    Output: [1]



Expected Viva Questions
1. What is NFT?
An NFT (Non-Fungible Token) is a unique digital asset stored on blockchain representing ownership.

2. What is metadata URI?
It stores information about NFT such as:
    image
    name
    description
    Why is tokenId unique?
Each NFT must have a unique identifier for ownership tracking.

3. What is msg.sender?
Address of the user calling the smart contract function.

4. Difference between NFT and Cryptocurrency?
NFT	                       Cryptocurrency
Unique	                   Fungible
Cannot replace each other  Interchangeable
Represents ownership	   Represents currency