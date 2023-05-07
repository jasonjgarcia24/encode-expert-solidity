// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";

interface ICTF_4_02 {
    function solution(
        uint256[2] calldata x,
        uint256[2] calldata y
    ) external pure returns (uint256[2] memory);
}

contract CTF_4_02 {
    function solution(
        uint256[10] calldata unsortedArray
    ) external payable returns (uint256[10] memory sortedArray) {
        assembly {
            // unsortedArray @ 0x0004 - 0x0124
            // sortedArray   @ 0x0080 - 0x01a0

            calldatacopy(0x00, 0x04, 0x0140)

            let swapped := 0
            let next := 0
            let actual := 0

            let i := 1

            for { } lt(i, 10) { } {
                let j := 0

                for { } lt(j, 9) { } {
                    next := mload(mul(0x20, add(j, 1)))
                    actual := mload(mul(0x20, j))

                    if lt(next, actual) {
                        mstore(mul(0x20, j), next)
                        mstore(mul(0x20, add(j, 1)), actual)
                        swapped := 1
                    }

                    j := add(j, 1)
                }

                if eq(swapped, 0) {
                    return (0x00, 0x01e0)
                }

                swapped := 0
                i := add(i, 1)
            }
        }
    }
}
