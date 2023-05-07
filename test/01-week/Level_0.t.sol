// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

// import "forge-std/Test.sol";
// import "../src/01_week/Level_0_00.sol";
// import "../src/01_week/Level_0_01.sol";
// import "../src/01_week/Level_0_02.sol";

// contract CTF00Test is Test {
//     Level_0_Solution_00 public ctf00;
//     Level_0_Solution_01 public ctf00_1;
//     Level_0_Solution_02 public ctf00_2;

//     function setUp() public {
//         ctf00 = new Level_0_Solution_00();
//         ctf00_1 = new Level_0_Solution_01();
//         ctf00_2 = new Level_0_Solution_02();
//     }

//     function test_Solution_00() public view {
//         uint8 _solution = ctf00.solution_00();

//         console.log(_solution);
//     }

//     function test_solution_01() public view {
//         uint256[2][2] memory x = [
//             [uint256(300), uint256(2)],
//             [uint256(3), uint256(4)]
//         ];
//         uint256[2][2] memory y = [
//             [uint256(10), uint256(20)],
//             [uint256(30), uint256(40)]
//         ];

//         uint256[2][2] memory _solution = ctf00_1.solution(x, y);

//         console.log(_solution[0][0]);
//         console.log(_solution[0][1]);
//         console.log(_solution[1][0]);
//         console.log(_solution[1][1]);
//     }

//     function test_solution_02() public view {
//         uint256[10] memory x = [
//             uint256(2),
//             uint256(3),
//             uint256(1),
//             uint256(4),
//             uint256(10),
//             uint256(5),
//             uint256(6),
//             uint256(7),
//             uint256(9),
//             uint256(8)
//         ];

//         uint256[10] memory _solution = ctf00_2.solution(x);

//         console.log(_solution[0]);
//         console.log(_solution[1]);
//         console.log(_solution[2]);
//         console.log(_solution[3]);
//         console.log(_solution[4]);
//         console.log(_solution[5]);
//         console.log(_solution[6]);
//         console.log(_solution[7]);
//         console.log(_solution[8]);
//         console.log(_solution[9]);
//     }
// }
