// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract EthPool is Ownable {

    uint256 public balance;
    mapping(address => uint) public balances;

    constructor() {
        balance = 0;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        balance += msg.value;
    }

    function depositRewards() external payable onlyOwner() {
        balance += msg.value;
    }
}
