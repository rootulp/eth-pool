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

    function setUp() public {
        ethPool = new EthPool();
        cheats.deal(alice, 10 ether);
        cheats.deal(bob, 10 ether);
    }

    function testOwner() public {
        assertEq(owner, ethPool.owner());
    }

    function testDepositRewardsAsOwner() public {
        ethPool.depositRewards{value: 1 ether}();
        assertEq(ethPool.totalBalance(), 1 ether);
    }

    function testFailDepositRewardsAsAlice() public {
        cheats.prank(alice);
        ethPool.depositRewards{value: 1 ether}();
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

    function testDepositRewards() public {
        cheats.prank(alice);
        ethPool.deposit{value: 1 ether}();
        cheats.prank(bob);
        ethPool.deposit{value: 3 ether}();

        ethPool.depositRewards{value: 1 ether}();

        assertEq(ethPool.balances(alice), 1.25 ether);
        assertEq(ethPool.balances(bob), 3.75 ether);
    }
}

interface CheatCodes {
    function prank(address) external;
    function deal(address who, uint256 newBalance) external;
}
