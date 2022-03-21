// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "ds-test/test.sol";
import "../EthPool.sol";

contract EthPoolTest is DSTest {

    EthPool ethPool;
    address owner = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;
    // address alice = address(0xCAFE);
    // address bob = address(0xBEEF);

    function setUp() public {
        ethPool = new EthPool();
    }

    function testOwner() public {
        assertEq(owner, ethPool.owner());
    }

    function testOwnerDepositRewards() public {
        ethPool.depositRewards{value: 1 ether}();
        assertEq(ethPool.balance(), 1 ether);
    }
}
