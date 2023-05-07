# Assembly II
***
## 1. Create a solidity contract with one function that returns the amount of ETH passed to it.<br>
This function body should be written in only assembly.

```js
contract Homework06_01 {
    function solution() external payable returns (uint256) {
        assembly {
            mstore(0x40, callvalue())
            return(0x40, 0x20)
        }
    }
}
```

`forge test --match-test test__solution__HW06_01`

***
## 2. What is this code doing?<br>
```
push9 0x601e8060093d393df3
msize
mstore                      # mem = 000...000 601e8060093d393df3
                            #     = 000...000 spawned constructor payload

# copy the runtime bytecode after the constructor code in mem
codesize                    # cs
returndatasize              # 0 cs
msize                       # 0x20 0 cs
codecopy                    # mem = 000...000 601e8060093d393df3 RUNTIME_BYTECODE


                            # --- stack ---
push1 9                     # 9
codesize                    # cs 9
add                         # cs+9 = CS = total codesize in memory

push1 23                    # 23 CS
returndatasize              # 0 23 CS
dup3                        # CS 0 23 CS

dup3                        # 23 CS 0 23 CS
callvalue                   # v 23 CS 0 23 CS
create                      # addr1 0 23 CS
pop                         # 0 23 CS

create                      # addr2

selfdestruct
```

|Opcode                      |Description                   |
|----------------------------|------------------------------|
|`push9 0x601e8060093d393df3`|Place 9 byte item on stack    |
|msize                       |Get the size of active memory in bytes|
|mstore                      |Save word to memory           |
|copy the runtime bytecode after the contructor code in memory||
|codesize                    |Get the size of code running in current environment|
|returndatasize              |Get the size of output data from the previous call from the current environment|
|msize                       |Get the size of active memory in bytes|
|codecopy                    |Copy code running in current environment to memory|
|push1 9                     |Place 1 byte item on stack    |
|codesize                    |Get the size of code running in current environment|
|add                         |Addition operation            |
|push1 23                    |Place 1 byte item on stack    |
|returndatasize              |Get size of output data from the previous call from the current environment|
|dup3                        |Duplicate third stack item    |
|dup3                        |Duplicate third stack item    |
|callvalue                   |Get deposited value by the instruction/transaction responsible for this execution|
|create                      |Create a new account with associated code|
|pop                         |Remove item from stack        |
|create                      |Create a new account with associated code|
|selfdestruct                |Halt execution and register account for later deletion|<br>

This bytecode sequence creates and deploys a smart contract. The bytecode first pushes some data onto the stack, which represents the constructor payload for the new contract (0x601e8060093d393df3). Then it stores this data in memory using the `mstore` opcode.<br>

Then, the code copies the runtime bytecode after the constructor code in memory to a new location in memory.<br>

The remaining opcodes create a new contract and self-destruct the existing one:<br>

1. `push1 9`, `codesize`, and `add` are used to calculate the total size of the memory needed for the contract's bytecode.<br>
2. `returndatasize` and `dup3` are used to set up the arguments for the `create` opcode, which creates a new contract with the given bytecode.<br>
3. The `selfdestruct` opcode is used to destroy the existing contract and send any remaining funds to the specified address.<br>

***
## 3. Explanation on the following Yul ERC20 code
```js
function allowanceStorageOffset(account, sender) -> offset {language-js
    offset := accountToStorageOffset(account)
    mstore(0, offset)
    mstore(0x20, spender)
    offset := keccak256(0, 0x40)
}
```

This code is finding the mapping key into the ERC20 allowance of a specific `sender` for `account`'s balance. In other words, it finds `senderKey` within `mapping(accountKey address => mapping(senderKey address => uint256)) private _allowances;`.<br>

### Line-by-Line Breakdown:<br>
- `offset := accountToStorageOffset(account)` - Collect the `accountKey`. This key is derived from `keccak256(h(k) . p)` where `.` is concatenation, `h` represents the padding of the `sender` address to 32 bytes, and `p` is the storage slot of the mapping.<br>

- `mstore(0, offset)` - Store the `accountKey` at 0x00.<br>

- `mstore(0x20, spender)` - Store the `spender` address at 0x20 (concatenated with `accountKey`). This can be represented as `abi.encode(spender) . keccak256(abi.encode(account) . p)`.<br>

- `offset := keccak256(0, 0x40)` - Perform a keccak256 hashing of the concatenated key information. This can be represented as `keccak256(abi.encode(spender) . keccak256(abi.encode(account) . p))`.