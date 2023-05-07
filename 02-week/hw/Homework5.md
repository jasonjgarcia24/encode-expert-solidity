# Assembly I
***
## 1. When we do the CODECOPY operation, what are we overwriting?<br>
In this instance, we overwrite memory starting at 0x00 and ending at 0xa0 with the code running in the current environment. This thereforre overwrites the free memory pointer (i.e 0x40).

### <u>Init code (see <a href="https://gist.github.com/extropyCoder/4243c0f90e6a6e97006a31f5b9265b94">gist</a>):</u><br>
```js
// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

contract Deploy1{

    uint256 value1;

    constructor(){
        value1 = 17;
    }

    function read() view public returns (uint256 result){
        return value1;
    }
}
```
### <u>Init Code Bytecode:</u><br>
<code><u>608060405234801561001057600080fd5b50601160008190555060b6806100276000396000f3fe</u>6080604052348015600f57600080fd5b506004361060285760003560e01c806357de26a414602d575b600080fd5b60336047565b604051603e9190605d565b60405180910390f35b60008054905090565b6057816076565b82525050565b6000602082019050607060008301846050565b92915050565b600081905091905056fea2646970667358221220872b5d4b9f200afddd5ed3c424f6b3b995bf467e212ec4c313f65365aeadf8e964736f6c63430008060033</code><br>

Where the **initialization** code is:<br><u>`608060405234801561001057600080fd5b50601160008190555060b6806100276000396000f3fe`</u><br>

And the rest is the **runtime** code.<br>

### <u>Initialization Opcode Breakdown:</u><br>

016 JUMPDEST - marks this location as a valid JUMP target<br>
017 POP - Removes 0x00 from stack<br>
018 PUSH1 11 - Pushes a UInt8, 0x11 (d17) onto the stack<br>
020 PUSH1 00 - Pushes 0x00 onto the stack<br>
022 DUP2 - Duplicates the second item on the stack (0x11)<br>
023 SWAP1 - Swaps the first and second item on the stack<br>
024 SSTORE - Stores key/value (0x00/0x11) to storage<br>
025 POP - Pops 0x11 from the stack<br>
026 PUSH1 b6 - Pushes a UInt8, 0xb6 (d182) to the stack<br>
028 DUP1 - Duplicates 0xb6 on the stack<br>
029 PUSH2 0027 - Pushes a UInt16, 0x27 (d39) to the stack<br>
032 PUSH1 00 - Pushes a UInt8, 0x00 to the stack<br>
034 CODECOPY - Copy's executing code's bytecode to memory<br>
035 PUSH1 00 - Pushes a Uint8, 0x00 to the stack<br>
037 RETURN - Returns from the contract call<br>

***
## 2. Could the answer to Q1 allow an optimisation?<br>
It can. An optimization therefore would be to not originally set up the free memory pointer and overwrite it at a later time.

***
## 3. Can you triger a revert in the init code in Remix?
Yes, by sending the contract ETH during contract creation, the initial non-payable check will fail and result in a revert:<br>

005 CALLVALUE - Stores nonzero ETH value on the stack<br>
006 DUP1 - Duplicates the nonzero value on the stack<br>
007 ISZERO - Consumes the first nonzero value on the stack, results in `False`<br>
008 PUSH2 0010 - Pushes UInt16, 0x10 on the stack<br>
<strong>011 JUMPI - Jumps to destination 0x10 if the callvalue was 0x00</strong><br>
012 PUSH1 00 - Pushes 0x00 on the stack<br>
014 DUP1 - Duplicates the 0x00 on the stack<br>
<strong>015 REVERT - Reverts due to nonzero callvalue</strong><br>

***
## 4. Write some Yul to:
1. Add 0x07 and 0x08
   - See [Homework05_04.sol:Homework05_04_01](./Homework05_04.sol)</a>
2. Store the result at the next free memory location
   - See [Homework05_04.sol:Homework05_04_02](./Homework05_04.sol)</a>
3. (optional) Write this again in opcodes<br>

|Mnemonic     |UInt8    |
|-------------|---------|
|PUSH1 (0X80) |60 80    |
|PUSH1 (0X40) |60 40    |
|MSTORE       |52       |
|CALLVALUE    |34       |
|DUP1         |80       |
|ISZERO       |15       |
|PUSH1        |60 0f    |
|JUMPI        |57       |
|JUMPDEST     |5b       |
|POP          |50       |
|PUSH1 (0x04) |60 04    |
|CALLDATASIZE |36       |
|LT           |10       |
|PUSH1 (0x28) |60 28    |
|JUMPI        |57       |
|PUSH1 (0x00) |60 00    |
|CALLDATALOAD |35       |
|PUSH1 (0xe0) |60 e0    |
|SHR          |1c       |
|DUP1         |80       |
|PUSH4 (0x4f2be91f)|63 43 2b e9 1f|
|EQ           |14       |
|PUSH1 (0x2d) |60 2d    |
|JUMPI        |57       |
|JUMPDEST     |5b       |
|PUSH1 (0x36) |60 36    |
|PUSH1 (0x0f) |60 0f    |
|PUSH1 (0x00) |60 00    |
|MSTORE       |52       |
|JUMP         |56       |
|JUMPDEST     |5b       |
|STOP         |00       |
-- fin