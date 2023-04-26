// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

error IndexOutOfRange();

/*
 * Write a function that will delete items (one at a time) from
 * a dynamic array without leaving gaps in the array. You should
 * assume that the items to be deleted are chosen at random, and
 * try to do this in a gas efficient manner.
 *
 * For example imagine your array has 12 items and you need to
 * delete the items at indices 8, 2, and 7.
 * The final array will then have items {0, 1, 3, 4, 5, 6, 9, 10, 11}
 */
contract Homework02 {
    uint256[] private __myArray;

    constructor() {}

    function setMyArray(uint256[] memory _myArray) external {
        for (uint256 i; i < _myArray.length; i++) {
            __myArray.push(_myArray[i]);
        }
    }

    function myArray() external view returns (uint256[] memory) {
        return __myArray;
    }

    function deleteAt(uint256 _index) external {
        if (_index > __myArray.length) revert IndexOutOfRange();

        uint256 _lastIndex = __myArray.length - 1;

        __myArray[_index] = __myArray[_lastIndex];
        __myArray.pop();
    }
}
