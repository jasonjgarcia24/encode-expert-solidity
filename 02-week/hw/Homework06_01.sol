// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract Homework06_01 {
    function solution() external payable returns (uint256) {
        assembly {
            mstore(0x40, callvalue())
            return(0x40, 0x20)
        }
    }
}
