// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

interface ICTF_4_00 {
    function solution() external pure returns (uint8);

    function setSolution(uint256) external;
}

contract CTF_4_00 {
    ICTF_4_00 ctf = ICTF_4_00(address(0));
    
    constructor() {
        // ctf.setSolution(42);
    }

    function solution() external payable returns (uint8) {
        assembly {
            mstore(0x40, 0x2a)
            return(0x40, 0x20)
        }
    }
}
