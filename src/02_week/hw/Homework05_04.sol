// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Homework05_04 {
    function add() external pure {
        assembly {
            mstore(0, add(0x07, 0x08))
        }
    }
}
