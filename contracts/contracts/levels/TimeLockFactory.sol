// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import './base/Level.sol';
import './TimeLock.sol';

contract TimeLockFactory is Level {

  function createInstance(address _player) override public payable returns (address) {
    _player;
    return address(new TimeLock());
  }

  function validateInstance(address payable _instance, address _player) override public returns (bool) {
    _player;
    TimeLock instance = TimeLock(_instance);
    return instance.completed();
  }
}
