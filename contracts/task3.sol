// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract UserBalanceContract {
    struct User {
        address id;
        string name;
        uint256 age;
        uint256 balance;
        bool exists;
    }

    // balance mapping
    mapping(address => User) users;

    modifier UserExists() {
        require(users[msg.sender].exists == true, "User doesn't exist");
        _;
    }

    modifier UserNotExists() {
        require(users[msg.sender].exists == false, "User exists");
        _;
    }

    function setUserDetails(string calldata _name, uint256 _age) public UserNotExists {
        users[msg.sender] = User({id : msg.sender, name : _name, age : _age, balance : 0, exists : true});
    }

    function getUserDetails() public view UserExists returns (User memory) {
        return users[msg.sender];
    }

    function deposit(uint256 _amount) external UserExists {
        users[msg.sender].balance += _amount;
    }

    function checkBalance() public view UserExists returns (uint256) {
        return (users[msg.sender].balance);
    }
}