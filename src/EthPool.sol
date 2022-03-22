// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

/// @title EthPool provides a pool for users to deposit into in order to earn rewards in ETH
/// @author Rootul Patel
/// @notice You can use this contract to deposit ETH into. If a pool operator deposits rewards
/// into the pool while you have funds in the pool, you will be distributed some of the rewards proportional to your share of the total pool. You may withdraw your entire balance at any time.
/// @dev This is an unaudited contract and shouldn't be used in production
contract EthPool is Ownable {

    // State
    address[] internal depositors;
    mapping(address => uint) public balances;
    uint256 public totalBalance;

    // Events
    event DistributeReward(uint amount);
    event Deposit(address indexed from, uint amount);
    event Withdrawal(address indexed to, uint amount);

    constructor() {} // no-op

    function deposit() external payable {
        require(msg.sender != address(0));
        require(msg.value > 0, "Value must be greater than zero");

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
