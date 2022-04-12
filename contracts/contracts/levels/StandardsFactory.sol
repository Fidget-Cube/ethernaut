// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import './base/Level.sol';
import './Standards.sol';

contract StandardsFactory is Level {

  function createInstance(address _player) override public payable returns (address) {
    _player;
    return address(new Standards());
  }

  function validateInstance(address payable _instance, address _player) override public returns (bool) {
    _player;
    Standards instance = Standards(_instance);
    return instance.balanceOf(_player) > 0;
  }
}
