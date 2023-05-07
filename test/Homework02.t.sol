// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/01_week/hw/Homework02.sol";

contract CounterTest is Test {
    Homework02_01 public hw02_01;

    uint256 public arrayLength = 12;
    uint256[] public array = new uint256[](arrayLength);

    function setUp() public {
        hw02_01 = new Homework02_01();

        for (uint i; i < arrayLength; i++) {
            array[i] = i * 3;
        }
    }

    function test__deleteAt__HW02_01() public {
        uint256 _arrayLength = array.length;
        uint256 _lastElement = array[_arrayLength - 1];

        for (uint256 i; i < arrayLength - 2; i++) {
            uint256 _i = bound(i, 0, array.length - 1);

            array = hw02_01.deleteAt(array, _i);

            assertEq(
                array[_i],
                _lastElement,
                "Array element was not removed correctly."
            );

            assertEq(
                array.length,
                _arrayLength - 1,
                "Array length is unchanged."
            );

            _arrayLength = array.length;
            _lastElement = array[_arrayLength - 1];
        }
    }
}
