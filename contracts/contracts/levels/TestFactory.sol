// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import './base/Level.sol';
import './Test.sol';

contract TestFactory is Level {

  function createInstance(address _player) override public payable returns (address) {
    _player;
    return address(new Test());
  }

  function validateInstance(address payable _instance, address _player) override public returns (bool) {
    _player;
    Test instance = Test(_instance);
    return instance.completed();
  }
}
