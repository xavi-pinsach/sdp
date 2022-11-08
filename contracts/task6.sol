// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract task6Token is ERC20, ERCDetailed {
    constructor(uint256 initialSupply) ERC20Detailed("task6", "TSK6", 18) public {
        _mint(msg.sender, initialSupply);
    }
}