// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "ds-test/test.sol";
import "../EthPool.sol";

contract EthPoolTest is DSTest {

    EthPool ethPool;
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);

    address constant owner = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;
    address constant alice = address(0xCAFE);
    address constant bob = address(0xBEEF);
    address constant charlie = address(0xFEED);

    function setUp() public {
        ethPool = new EthPool();
        cheats.deal(alice, 10 ether);
        cheats.deal(bob, 10 ether);
        cheats.deal(charlie, 10 ether);
    }

    function testOwner() public {
        assertEq(owner, ethPool.owner());
    }

    function testDistributeRewardAsOwner() public {
        ethPool.distributeReward{value: 1 ether}();
        assertEq(ethPool.totalBalance(), 1 ether);
    }

    function testFailDistributeRewardAsAlice() public {
        cheats.prank(alice);
        ethPool.distributeReward{value: 1 ether}();
    }

    function testOneDeposit() public {
        cheats.prank(alice);
        ethPool.deposit{value: 1 ether}();
        assertEq(ethPool.balances(alice), 1 ether);
    }

    function testTwoDeposits() public {
        cheats.prank(alice);
        ethPool.deposit{value: 1 ether}();
        cheats.prank(bob);
        ethPool.deposit{value: 1 ether}();

        assertEq(ethPool.balances(alice), 1 ether);
        assertEq(ethPool.balances(bob), 1 ether);
    }

    function testDistributeReward() public {
        cheats.prank(alice);
        ethPool.deposit{value: 1 ether}();
        cheats.prank(bob);
        ethPool.deposit{value: 1 ether}();

        ethPool.distributeReward{value: 1 ether}();

        assertEq(ethPool.balances(alice), 1.5 ether);
        assertEq(ethPool.balances(bob), 1.5 ether);
    }

    function testWithdrawAsAlice() public {
        cheats.prank(alice);
        ethPool.deposit{value: 1 ether}();
        cheats.prank(bob);
        ethPool.deposit{value: 3 ether}();

        ethPool.distributeReward{value: 1 ether}();

        cheats.prank(alice);
        ethPool.withdraw();
        assertEq(ethPool.balances(alice), 0 ether);
        assertEq(ethPool.totalBalance(), 3.75 ether);
        assertEq(address(alice).balance, 10.25 ether);
    }

    function testNoRewardsForCharlie() public {
        cheats.prank(alice);
        ethPool.deposit{value: 1 ether}();
        cheats.prank(bob);
        ethPool.deposit{value: 3 ether}();

        ethPool.distributeReward{value: 1 ether}();

        cheats.prank(charlie);
        ethPool.deposit{value: 2 ether}();
        assertEq(ethPool.balances(charlie), 2 ether);
    }

    function testWithdrawRevertsIfBalanceIsZero() public {
        cheats.expectRevert(
            bytes("User balance is zero")
        );
        cheats.prank(alice);
        ethPool.withdraw();
    }

    function testDepositValueOfZero() public {
        cheats.expectRevert(
            bytes("Value must be greater than zero")
        );
        cheats.prank(alice);
        ethPool.deposit{value: 0}();
    }

    function testDepositFuzzAmount(uint amount) public {
        cheats.assume(amount > 0 ether);
        cheats.deal(alice, amount);
        uint preBalance = alice.balance;
        cheats.startPrank(alice);
        ethPool.deposit{value: amount}();
        ethPool.withdraw();

        uint postBalance = alice.balance;
        assertEq(preBalance, postBalance);
    }
}

interface CheatCodes {
    function assume(bool) external;
    function deal(address who, uint256 newBalance) external;
    function expectRevert(bytes calldata) external;
    function prank(address) external;
    function startPrank(address) external;
}
