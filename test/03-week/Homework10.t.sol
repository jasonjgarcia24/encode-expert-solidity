// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {Homework10_02a, Homework10_02b} from "../../03-week/hw/Homework10.sol";

contract TestHomework10_02 is Test {
    Homework10_02a public hw10_02a;
    Homework10_02b public hw10_02b;

    function setUp() public {
        hw10_02a = new Homework10_02a();
        hw10_02b = new Homework10_02b();
    }

    function test__div_a__HW10_02(uint256 _num, uint256 _den) public view {
        _num = bound(_num, 1, type(uint256).max);
        _den = bound(_den, 1, type(uint256).max);

        hw10_02a.div(_num, _den);
    }

    function test__div_b__HW10_02(uint256 _num, uint256 _den) public view {
        _num = bound(_num, 1, type(uint256).max);
        _den = bound(_den, 1, type(uint256).max);

        hw10_02b.div(_num, _den);
    }
}
