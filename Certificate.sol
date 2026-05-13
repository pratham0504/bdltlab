// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateVerification {

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    struct Certificate {
        string studentName;
        string courseName;
        uint issueDate;
        address issuedTo;
        bool valid;
    }

    mapping(uint => Certificate) public certificates;

    // Issue Certificate
    function issueCertificate(
        uint _certId,
        string memory _studentName,
        string memory _courseName,
        address _issuedTo
    ) public {

        require(msg.sender == admin, "Only admin can issue certificates");
        require(!certificates[_certId].valid, "Certificate ID already exists");

        certificates[_certId] = Certificate(
            _studentName,
            _courseName,
            block.timestamp,
            _issuedTo,
            true
        );
    }

    // Verify Certificate
    function verifyCertificate(uint _certId)
        public
        view
        returns (
            string memory,
            string memory,
            uint,
            address,
            bool
        )
    {
        Certificate memory cert = certificates[_certId];

        return (
            cert.studentName,
            cert.courseName,
            cert.issueDate,
            cert.issuedTo,
            cert.valid
        );
    }
}

<!-- How to Perform in Practical
1. Open Remix

2. Create File
CertificateVerification.sol
Paste the code.

3. Compile

4. Connect MetaMask

5. Deploy Contract

Testing Steps for Practical
A. Issue Certificate
    Expand deployed contract.

    In issueCertificate enter:
        _certId → 1
        _studentName → "Rahul Sharma"
        _courseName → "Blockchain Course"
        _issuedTo → student wallet address

    Click issueCertificate
    Approve MetaMask transaction.

B. Verify Certificate
    In verifyCertificate enter:
    1

    Click button.

    You will get:
        Student name
        Course name
        Issue date
        Wallet address
        true meaning valid certificate


VIVA QUESTIONS:
1. Why blockchain for certificates?
Because records cannot be modified easily and verification is transparent.

2. What is mapping?
It stores certificate data using certificate ID as key.

3. Why use block.timestamp?
To store certificate issue time.

4. What does require do?
It validates conditions and stops invalid transactions.

5. Who is admin?
The MetaMask account that deploys the contract.