// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import './base/Level.sol';
import './Conventions.sol';

contract ConventionsFactory is Level {

  function createInstance(address _player) override public payable returns (address) {
    _player;
    return address(new Conventions());
  }

  function validateInstance(address payable _instance, address _player) override public returns (bool) {
    _player;
    Conventions instance = Conventions(_instance);
    return instance.balanceOf(_player) > 0;
  }
}
