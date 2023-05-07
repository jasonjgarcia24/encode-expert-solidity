// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/console.sol";

interface ICTF_4_01 {
    function solution(
        uint256[2] calldata x,
        uint256[2] calldata y
    ) external pure returns (uint256[2] memory);
}

contract CTF_4_01 {
    constructor() payable {}

    function solution(
        uint256[2][2] calldata x,
        uint256[2][2] calldata y
    ) external payable returns (uint256[2][2] memory) {
        assembly {
            // x @ 0x04
            // y @ 0x84

            mstore(0x40, add(calldataload(x), calldataload(y)))

            mstore(
                0x60,
                add(calldataload(0x24), calldataload(0xa4))
            )

            mstore(
                0x80,
                add(calldataload(0x44), calldataload(0xc4))
            )

            mstore(
                0xa0,
                add(calldataload(0x64), calldataload(0xe4))
            )

            return(0x40, 0x80)
        }
    }
}
