pragma solidity 0.8.17;

contract AssemblyArrays {
    bytes testArray;

    function getLength() public view returns (uint256) {
        bytes memory memoryTestArray = testArray;
        uint256 result;
        assembly {
            result := mload(memoryTestArray)
        }
        return result;
    }

    function getElement(uint256 index) public view returns (bytes1) {
        return testArray[index];
    }

    function pushElement(bytes1 value) public {
        testArray.push(value);
    }

    function updateElement(bytes1 value, uint256 index) public {
        testArray[index] = value;
    }
}
