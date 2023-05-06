// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/02_week/Homework05_01.sol";
import "../src/02_week/Homework05_04.sol";

contract testHomework05 is Test {
    Homework05_04 hw05_04;

    function setUp() public {
        hw05_04 = new Homework05_04();
    }

    function testDeployHW05_01() public {
        Deploy1 deploy1 = new Deploy1();
    }

    function testAddHW05_04() public view {
        hw05_04.add();
    }
}
