// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../../02-week/hw/Homework05_01.sol";
import {Homework05_04_01, Homework05_04_02} from "../../02-week/hw/Homework05_04.sol";

contract testHomework05 is Test {
    Homework05_04_01 hw05_04_01;
    Homework05_04_02 hw05_04_02;

    function setUp() public {
        hw05_04_01 = new Homework05_04_01();
        hw05_04_02 = new Homework05_04_02();
    }

    function testDeployHW05_01() public {
        // Deploy1 deploy1 = new Deploy1();
    }

    function test__add__HW05_04_01() public {
        assertEq(hw05_04_01.add(), 15, "Must equal 15.");
    }

    function test__add__HW05_04_02() public {
        assertEq(hw05_04_02.add(), 15, "Must equal 15.");
    }
}
