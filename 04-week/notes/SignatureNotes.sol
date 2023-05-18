// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract SignatureNotes {
    function chainId() public view returns (uint256) {
        return block.chainid;
    }
}
