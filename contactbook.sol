// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract ContactBook {
    struct Contact {
        string name;
        address addr;
    }

    address public owner;
    string public ownerName;
    Contact[] public contacts;
    mapping(address => uint) public contactIndex;

    event NewContact(string name, address addr);

    constructor(string memory _ownerName) {
        owner = msg.sender;
        ownerName = _ownerName;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can add contacts");
        _;
    }

    function addContact(string memory _name, address _addr) public onlyOwner {
        contacts.push(Contact(_name, _addr));
        contactIndex[_addr] = contacts.length - 1;
        emit NewContact(_name, _addr);
    }

    function findContactByAddress(address _addr) public view returns (string memory) {
        return contacts[contactIndex[_addr]].name;
    }

    function findContactByIndex(uint _index) public view returns (string memory, address) {
        return (contacts[_index].name, contacts[_index].addr);
    }
}
