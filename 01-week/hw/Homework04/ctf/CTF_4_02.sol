// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

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
    ) external view returns (uint256[10] memory sortedArray) {
        // uint256 ceil;

        assembly {
            let ptr := 0x0080
            let end := 9
            let currentElement
            let nextElement

            // unsortedArray @ 0x0004 - 0x0124
            // sortedArray   @ 0x0080 - 0x01a0

            // 0
            mstore(0x0080, calldataload(0x0004))
            mstore(0x00a0, calldataload(0x0024))
            mstore(0x00c0, calldataload(0x0044))
            mstore(0x00e0, calldataload(0x0064))
            mstore(0x0100, calldataload(0x0084))
            mstore(0x0120, calldataload(0x00a4))
            mstore(0x0140, calldataload(0x00c4))
            mstore(0x0160, calldataload(0x00e4))
            mstore(0x0180, calldataload(0x0104))
            mstore(0x01a0, calldataload(0x0124))

            for {
                let i := 0
            } lt(i, end) {
                i := add(i, 1)
            } {
                currentElement := calldataload(add(0x04, mul(0x20, i)))
                nextElement := mload(add(0x0080, mul(0x20, add(i, 1))))

                switch lt(
                    mload(add(0x0080, mul(0x20, add(i, 1)))),
                    currentElement
                )
                case true {
                    mstore(add(0x0080, mul(0x20, i)), nextElement)
                    ptr := add(ptr, 0x20)
                    mstore(add(0x0080, mul(0x20, add(i, 1))), currentElement)
                }
                case false {
                    ptr := add(ptr, 0x20)
                }
                //     case false {
                //         mstore(add(ptr, 0x20), mload(ptr))
                //         mstore(ptr, calldataload(add(0x24, mul(0x20, i))))
                //     }
            }

            // if gt(mload(0x0080), )

            // mload(0x80)
            // x @ 0x04
            // y @ 0x84
            // _result @ 0x80
            // // mstore(0xc0, add(calldataload(x), calldataload(y)))
            // mstore(0xc0, add(calldataload(0x04), calldataload(0x84)))
            // mstore(0xe0, add(calldataload(0x24), calldataload(0xa4)))
            // mstore(0x0100, add(calldataload(0x44), calldataload(0xc4)))
            // mstore(0x0120, add(calldataload(0x64), calldataload(0xe4)))
        }
    }
}
