// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract UserBalanceContract {
    struct Balance {
        uint256 balance;
        bool exists;
    }

    // balance mapping
    mapping(address => Balance) public balances;

    function deposit (uint256 amount) external {
        balances[msg.sender] = Balance({balance: balances[msg.sender].balance + amount, exists: true});
    }

    function checkBalance() public view returns (uint256){
        require(balances[msg.sender].exists == true, "Balance doesn't exist");

        return (balances[msg.sender].balance);
    }
}