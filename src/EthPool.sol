// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract EthPool is Ownable {

    event RewardsDeposited(uint amount);
    uint256 public balance;

    constructor() {
        balance = 0;
    }

    function depositRewards() external payable onlyOwner() {
        balance += msg.value;
        emit RewardsDeposited(msg.value);
    }
}
