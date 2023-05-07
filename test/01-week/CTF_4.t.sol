// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {CTF_4_00} from "../../01-week/hw/Homework04/ctf/CTF_4_00.sol";
import {CTF_4_01} from "../../01-week/hw/Homework04/ctf/CTF_4_01.sol";
import {CTF_4_02} from "../../01-week/hw/Homework04/ctf/CTF_4_02.sol";

contract CTF00Test is Test {
    CTF_4_00 public ctf00;
    CTF_4_01 public ctf01;
    CTF_4_02 public ctf02;

    function setUp() public {
        ctf00 = new CTF_4_00();
        ctf01 = new CTF_4_01();
        ctf02 = new CTF_4_02();
    }

    function test__CTF00() public {
        uint8 _solution = ctf00.solution();
        console.log(_solution);
    }

    function test__CTF01() public {
        uint256[2][2] memory x = [
            [uint256(300), uint256(2)],
            [uint256(3), uint256(4)]
        ];
        uint256[2][2] memory y = [
            [uint256(10), uint256(20)],
            [uint256(30), uint256(40)]
        ];

        uint256[2][2] memory _solution = ctf01.solution(x, y);

        console.log(_solution[0][0]);
        console.log(_solution[0][1]);
        console.log(_solution[1][0]);
        console.log(_solution[1][1]);
    }

    function test__CTF02() public {
        uint256[10] memory x = [
            uint256(block.timestamp),
            uint256(block.number),
            uint256(type(uint256).max/2),
            uint256(4),
            uint256(50),
            uint256(5),
            uint256(6),
            uint256(256),
            uint256(type(uint256).max),
            uint256(12)
        ];

        uint256[10] memory _solution = ctf02.solution(x);

        console.log(_solution[0]);
        console.log(_solution[1]);
        console.log(_solution[2]);
        console.log(_solution[3]);
        console.log(_solution[4]);
        console.log(_solution[5]);
        console.log(_solution[6]);
        console.log(_solution[7]);
        console.log(_solution[8]);
        console.log(_solution[9]);
    }
}
