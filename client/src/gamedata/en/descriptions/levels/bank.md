Welcome to the Ether bank! The function is pretty simple. You may deposit Ethereum, or you may withdraw deposited Ethereum.

This Contract requires a few basic Solidity concepts to understand. These explanations can be skipped for those already familiar with Solidity.
 - The `balance` variable defined is a "mapping", which is like a mapping in C++ or a dictionary in Python. The data type stores a list of (key => value) pairs. To access an element in the list, the variable name is invoked, as well as the name of the key, like `variable[key]`. Here, the variable has keys that are 20-byte addresses, which maps to an integer value.
 - Another thing to note is that this variable is `public`. This means that anyone can read its value (but cannot overwrite it). What actually happens in the background is the compiler creates a `view` function, with the same name as the variable, that simply returns the variable. 

To see your current balance, type this in the console:
```
contract.balance(player)
```
 - You may notice `msg.*` appearing at various places in the code. These are built-in objects that expose data about aspects of the blockchain. `msg.sender` is the address of the one calling the current function. `msg.value` is the amount of ETH the caller has sent to the current function. (For more information on the workings of the EVM, check out the [Ethereum documentation](https://ethereum.org/en/developers/docs/evm/))
 - Speaking of sending ETH, functions are only capable of receiving ETH if they have the `payable` modifier. ETH received by functions goes to the total ETH balance of the contract address.

To send ETH to a function during a call, add an argument `{value: <amount>}` to the function call, where <amount> is the amount of Wei you want to send (1 ETH = 10^18 Wei). For example:
```
contract.deposit({value: 10**18})
```
 - Another important Solidity concept to understand is the `require()` statement. `require()` will throw an error if the statement in its parenthesis is false, which will completely revert the entire function call. This is a crucial point with smart contracts - if any part of the code fails, the whole function call reverts.
 - Finally, pay attention to the statement `msg.sender.call()`. This allows a contract to call another contract on the chain. You don't need to worry about the workings of this call yet, just keep it in mind for future challenges.
 - If you need extra help or information, read up on the [Solidity docs](https://docs.soliditylang.org/en/v0.8.13/). You may also be able to find helpful examples online to help understand the code.

Go ahead and deposit some ETH into the contract, then withdraw it to pass this level.