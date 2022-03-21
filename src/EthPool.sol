// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract EthPool is Ownable {

    // State
    uint256 public totalBalance;
    address[] public users;
    mapping(address => uint) public balances;

    // Events
    event RewardDeposit(uint amount);
    event Deposit(address indexed from, uint amount);
    event Withdraw(address indexed to, uint amount);

    constructor() {
        totalBalance = 0;
    }

    function deposit() external payable {
        require(msg.sender != address(0));
        require(msg.value != 0);

        bool hasValue = balances[msg.sender] > 0;
        if (!hasValue){
            users.push(msg.sender);
        }

        balances[msg.sender] += msg.value;
        totalBalance += msg.value;

        assert(address(this).balance == totalBalance);
        emit Deposit(msg.sender, msg.value);
    }

    function depositRewards() external payable onlyOwner() {
        for (uint i = 0; i < users.length; i++) {
            address user = users[i];
            balances[user] += balances[user] * msg.value / totalBalance;
        }

        totalBalance += msg.value;
        emit RewardDeposit(msg.value);
    }

    function withdraw() public payable {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "User balance is 0");

        balances[msg.sender] = 0;
        totalBalance -= balance;
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Withdraw failed");
        emit Withdraw(msg.sender, balance);
    }
}
