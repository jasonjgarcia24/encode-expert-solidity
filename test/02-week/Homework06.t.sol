// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import { Homework06_01 } from "../../02-week/hw/Homework06_01.sol";


contract TestHomework06_01 is Test {
    Homework06_01 public hw06_01;

    function setUp() public {
        hw06_01 = new Homework06_01();
    }

    function test__solution__HW06_01(uint32 _value) public {
        (bool _success, bytes memory _data) = address(hw06_01).call{value: _value}(
            abi.encodeWithSignature("solution()")
        );
        require(_success, "Transfer failed");
        require(_value == uint256(bytes32(_data)), "Invalid payment return value");
    }
}