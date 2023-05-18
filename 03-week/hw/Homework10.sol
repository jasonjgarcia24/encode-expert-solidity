// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Homework10_02a {
    function div(
        uint256 _num,
        uint256 _den
    ) public pure returns (uint256 _result) {
        _result = _num / _den;
    }
}

contract Homework10_02b {
    function div(
        uint256 _num,
        uint256 _den
    ) public pure returns (uint256 _result) {
        assembly {
            _result := div(_num, _den)
        }
    }
}
