// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {

    struct Product {
        uint id;
        string name;
        address currentOwner;
        bool exists;
    }

    struct Tracking {
        address participant;
        string location;
        uint timestamp;
    }

    uint public productCount;

    mapping(uint => Product) public products;
    mapping(uint => Tracking[]) public productHistory;

    // Add new product
    function addProduct(string memory _name) public {

        productCount++;

        products[productCount] = Product(
            productCount,
            _name,
            msg.sender,
            true
        );

        productHistory[productCount].push(
            Tracking(
                msg.sender,
                "Manufactured",
                block.timestamp
            )
        );
    }

    // Transfer product ownership
    function transferProduct(
        uint _id,
        address _newOwner,
        string memory _location
    ) public {

        require(products[_id].exists, "Product does not exist");

        require(
            products[_id].currentOwner == msg.sender,
            "Only current owner can transfer"
        );

        products[_id].currentOwner = _newOwner;

        productHistory[_id].push(
            Tracking(
                _newOwner,
                _location,
                block.timestamp
            )
        );
    }

    // Get tracking count
    function getTrackingCount(uint _id)
        public
        view
        returns(uint)
    {
        return productHistory[_id].length;
    }

    // Get tracking details
    function getTracking(
        uint _id,
        uint index
    )
        public
        view
        returns(
            address,
            string memory,
            uint
        )
    {
        Tracking memory t = productHistory[_id][index];

        return (
            t.participant,
            t.location,
            t.timestamp
        );
    }
}


<!-- How to Perform in Practical
Step 1. Open Remix IDE

Step 2. Create File
SupplyChain.sol

Step 3. Compile

Step 4. Deploy

Step 5. Test Functions
1. Add Product
    Input
    Laptop

    Action
    Call:
    addProduct("Laptop")

    Expected Result
    Product created
    Owner becomes deployer address

    First tracking entry stored:
    "Manufactured"
    timestamp
    manufacturer address

2. Check Product Details
    Call:
    products(1)
    Output
    Product ID
    Product name
    Current owner address
    Exists = true

3. Transfer Product to Distributor
    Input
    Product ID = 1
    New owner = another MetaMask account
    Location = "Distributor"

    Action
    Call:
    transferProduct(1, address, "Distributor")

    Expected Result
    Ownership transferred

    Blockchain records:
    new participant address
    location
    timestamp

4. Transfer to Retailer
    Switch MetaMask to distributor account.

    Call:
    transferProduct(1, retailerAddress, "Retailer")

    Expected Result
    Retailer becomes owner
    New immutable tracking entry added

5. View Tracking History
    Call:
    getTrackingCount(1)

    Suppose output:
    3

    Now check each record:
    getTracking(1,0)
    getTracking(1,1)
    getTracking(1,2)

    Sample Output
    Step	Participant Address	  Location	     Timestamp
    0	    Manufacturer          Manufactured	 Stored
    1	    Distributor	          Distributor	 Stored
    2	    Retailer	          Retailer	     Stored
