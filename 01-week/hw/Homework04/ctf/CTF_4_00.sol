// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

interface ICTF_4_00 {
    function solution() external pure returns (uint8);
}

contract CTF_4_00 {
    function solution() external payable returns (uint8) {
        assembly {
            mstore(0x40, 0x2a)
            return(0x40, 0x20)
        }
    }
}
