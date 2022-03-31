// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import './base/Level.sol';
import './BankLock.sol';

contract BankLockFactory is Level {

  function createInstance(address _player) override public payable returns (address) {
    _player;
    return address(new BankLock());
  }

  function validateInstance(address payable _instance, address _player) override public returns (bool) {
    _player;
    BankLock instance = BankLock(_instance);
    return instance.completed();
  }
}
