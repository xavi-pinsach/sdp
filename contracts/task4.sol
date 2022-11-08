// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract UserBalanceContract {
    struct UserDetail {
        address id;
        string name;
        uint256 age;
        bool exists;
    }

    struct UserBalance {
        address id;
        uint256 balance;
        bool exists;
    }

    uint256 private fee;
    address private owner;

    // balance mapping
    mapping(address => UserDetail) usersDetails;
    mapping(address => UserBalance) usersBalances;

    constructor(uint256 _fee) {
        owner = msg.sender;
        fee = _fee;
    }

    error OnlyDeposited();
    error AmountTooSmall(uint256 available, uint256 required);

    modifier UserDetailExists() {
        require(usersDetails[msg.sender].exists == true, "User detail doesn\'t exist");
        _;
    }

    modifier UserDetailNotExists() {
        require(usersDetails[msg.sender].exists == false, "User detail already exists");
        _;
    }

    modifier UserBalanceExists() {
        require(usersBalances[msg.sender].exists == true, "User balance doesn\'t exist");
        _;
    }

    modifier UserBalanceNotExists() {
        require(usersBalances[msg.sender].exists == false, "User balance already exists");
        _;
    }

    modifier isOwner() {
        require(msg.sender == owner, "Operation only allowed to the owner of the contract");
        _;
    }

    modifier availableFee(uint256 _amount) {
        if (fee > _amount) {
            revert AmountToSmall({available: _amount, required: fee});
        }
        _;
    }

    function setUserDetails(string calldata _name, uint256 _age) public UserDetailNotExists {
        usersDetails[msg.sender] = UserDetail({id : msg.sender, name : _name, age : _age, exists : true});
    }

    function getUserDetails() public view UserDetailExists returns (UserDetail memory) {
        return usersDetails[msg.sender];
    }

    function deposit(uint256 _amount) external UserBalanceNotExists {
        usersBalances[msg.sender] = UserBalance({id : msg.sender, balance : _amount, exists : true});
    }

    function checkBalance() public view UserBalanceExists returns (uint256) {
        return (usersBalances[msg.sender].balance);
    }

    function withdraw(uint256 _amount) public isOwner UserBalanceExists {
        if (usersBalances[msg.sender] < _amount) {
            revert AmountToSmall({available : usersBalances[msg.sender], required : _amount});
        }

        usersBalances[msg.sender] -= amount;
    }

    function addFund(uint256 _amount) public availableFee(usersBalances[msg.sender] + _amount) {
        if(usersBalances[msg.sender].exists == false) {
            revert OnlyDeposited();
        }

        usersBalances[msg.sender] += amount - fee;
    }
}