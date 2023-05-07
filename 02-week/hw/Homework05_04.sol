// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/console.sol";

contract Homework05_04_01 {
    function add() external pure returns (uint256 _sum) {
        assembly {
            _sum := add(0x07, 0x08)
        }
    }
}

contract Homework05_04_02 {
    function add() external pure returns (uint256 _sum) {
        assembly {
            // Store at start of free memory pointer
            mstore(0x40, add(0x07, 0x08))

            // Load from start of free memory point
            // for validation only
            _sum := mload(0x40)
        }
    }
}
