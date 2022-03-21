// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract EthPool is Ownable {

    // State
    uint256 public totalBalance;
    address[] public depositors;
    mapping(address => uint) public balances;

    // Events
    event DistributeReward(uint amount);
    event Deposit(address indexed from, uint amount);
    event Withdrawal(address indexed to, uint amount);

    constructor() {
        totalBalance = 0;
    }

    function deposit() external payable {
        require(msg.sender != address(0));
        require(msg.value != 0);

        bool hasValue = balances[msg.sender] > 0;
        if (!hasValue){
            depositors.push(msg.sender);
        }

        balances[msg.sender] += msg.value;
        totalBalance += msg.value;

        assert(address(this).balance == totalBalance);
        emit Deposit(msg.sender, msg.value);
    }

    function distributeReward() external payable onlyOwner() {
        for (uint i = 0; i < depositors.length; i++) {
            address user = depositors[i];
            balances[user] += balances[user] * msg.value / totalBalance;
        }

        totalBalance += msg.value;
        emit DistributeReward(msg.value);
    }

    function withdraw() public payable {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "User balance is zero");

        balances[msg.sender] = 0;
        totalBalance -= balance;
        // TODO: we may remove msg.sender from depositors here

        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Withdrawal failed");
        emit Withdrawal(msg.sender, balance);
    }
}
