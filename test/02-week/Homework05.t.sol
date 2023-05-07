// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../../02-week/hw/Homework05_01.sol";
import {Homework05_04_01, Homework05_04_02} from "../../02-week/hw/Homework05_04.sol";
import {Intro} from "../../02-week/hw/assembly/Assembly_1.sol";
import {Add} from "../../02-week/hw/assembly/Assembly_2.sol";
import {SubOverflow} from "../../02-week/hw/assembly/Assembly_3.sol";
import {Scope} from "../../02-week/hw/assembly/Assembly_4.sol";

contract TestHomework05 is Test {
    Homework05_04_01 hw05_04_01;
    Homework05_04_02 hw05_04_02;

    Intro assembly1;
    Add assembly2;
    SubOverflow assembly3;
    Scope assembly4;

    function setUp() public {
        hw05_04_01 = new Homework05_04_01();
        hw05_04_02 = new Homework05_04_02();

        assembly1 = new Intro();
        assembly2 = new Add();
        assembly3 = new SubOverflow();
        assembly4 = new Scope();
    }

    function test__add__HW05_04_01() public {
        assertEq(hw05_04_01.add(), 15, "Must equal 15.");
    }

    function test__add__HW05_04_02() public {
        assertEq(hw05_04_02.add(), 15, "Must equal 15.");
    }
    function test__Assembly_1() public {
        assertEq(assembly1.intro(), 420, "The return value did not equal 420.");
    }

    function test__Assembly_2(uint128 x, uint128 y) public {
        uint256 _x = uint256(x);
        uint256 _y = uint256(y);

        assertEq(assembly2.addAssembly(_x, _y), _x + _y);
    }

    function test__Assembly_3() public {
        assertEq(assembly3.subtract(10, 3), 7);
        assertEq(assembly3.subtract(3, 10), 0);
    }

    function test__fuzz__Assembly_3(uint256 x, uint256 y) public {
        try HomeworkMath.sub(x, y) returns (uint256) {
            assertEq(assembly3.subtract(x, y), x - y);
        } catch {
            assertEq(assembly3.subtract(x, y), 0);
        }
    }

    function test__Assembly_4() public {
        assembly4.increment(1);
        assertEq(assembly4.count(), 11);
    }

    function test__fuzz__Assembly_4(uint128 num) public {
        uint256 _num = uint256(num);

        assembly4.increment(_num);
        assertEq(assembly4.count(), 10 + _num);
    }
}

library HomeworkMath {
    function sub(uint256 x, uint256 y) public pure returns (uint256) {
        return x - y;
    }
}

