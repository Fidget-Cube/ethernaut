Great work! It is common to find contracts in the wild that don't handle overflow correctly, but luckily it's an easy fix. The SafeMath library has math functions that raise an error on an unexpected operation, like an overflow.

This exploit is also depreciated. As of Solidity 0.8, any overflow or underflow will throw an error, reverting the function call.