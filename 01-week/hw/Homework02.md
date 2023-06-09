# Homework 2

***
## Array Element Deletion
Write a function that will delete items (one at a time) from a dynamic array without leaving gaps in the array. You should assume that the items to be deleted are chosen at random, and try to do this in a gas efficient manner.<br>

For example imagine your array has 12 items and you need to delete the items at indices 8, 2, and 7. The final array will then have items {0, 1, 3, 4, 5, 6, 9, 10, 11}.<br>

```js
contract Homework02_01 {
    uint256[] array;

    function deleteAt(uint256[] memory _array, uint256 _index) external returns (uint256[] memory) {
        if (_index > _array.length) revert IndexOutOfRange();
        // Dynamic array in storage required to use .pop() method
        array = _array;

        // Swap elemnt to remove with last element
        array[_index] = array[_array.length - 1];

        // Remove last element from array
        array.pop();

        return array;
    }
}
```