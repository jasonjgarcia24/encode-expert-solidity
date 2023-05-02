// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";

interface Isolution1_01 {
    function solution(
        uint256[2] calldata x,
        uint256[2] calldata y
    ) external pure returns (uint256[2] memory);
}

contract Level_0_Solution_01 {
    function solution(
        uint256[2][2] calldata x,
        uint256[2][2] calldata y
    ) external pure returns (uint256[2][2] memory _result) {
        assembly {
            // x @ 0x04
            // y @ 0x84
            // _result @ 0x80

            // mstore(0xc0, add(calldataload(x), calldataload(y)))
            // mstore(0xc0, add(calldataload(0x04), calldataload(0x84)))
            // mstore(0xe0, add(calldataload(0x24), calldataload(0xa4)))
            // mstore(0x0100, add(calldataload(0x44), calldataload(0xc4)))
            // mstore(0x0120, add(calldataload(0x64), calldataload(0xe4)))

            mstore(0xc0, add(calldataload(x), calldataload(y)))

            mstore(
                0xe0,
                add(calldataload(add(x, 0x20)), calldataload(add(y, 0x20)))
            )

            mstore(
                0x0100,
                add(calldataload(add(x, 0x40)), calldataload(add(y, 0x40)))
            )

            mstore(
                0x0120,
                add(calldataload(add(x, 0x60)), calldataload(add(y, 0x60)))
            )
        }
    }
}
