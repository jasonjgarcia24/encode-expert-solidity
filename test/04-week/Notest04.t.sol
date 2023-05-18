// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {SignatureNotes} from "../../04-week/notes/SignatureNotes.sol";

contract TestHomework05 is Test {
    SignatureNotes notes_04_00;

    function setUp() public {
        notes_04_00 = new SignatureNotes();
    }

    function testChainId() public view {
        console.log(notes_04_00.chainId());
    }
}
