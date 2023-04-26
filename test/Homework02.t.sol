// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Homework02.sol";

contract CounterTest is Test {
    Homework02 public hw02;

    uint256 public arrayLength = 12;
    uint256[] public array = new uint256[](arrayLength);

    function setUp() public {
        hw02 = new Homework02();

        for (uint i; i < arrayLength; i++) {
            array[i] = i * 3;
        }
    }

    function testDeleteAt() public {
        hw02.setMyArray(array);

        uint256[] memory _array = hw02.myArray();
        uint256 _arrayLength = _array.length;

        for (uint256 i; i < arrayLength - 2; i++) {
            uint256 _i = bound(i, 0, hw02.myArray().length - 1);
            hw02.deleteAt(_i);

            assertEq(
                hw02.myArray()[_i],
                _array[_array.length - 1],
                "Array element was not removed correctly."
            );

            assertEq(
                hw02.myArray().length,
                _arrayLength - 1,
                "Array length is unchanged."
            );

            _array = hw02.myArray();
            _arrayLength = _array.length;
        }
    }
}
