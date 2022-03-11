// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Test {
  bool public completed;
  function setCompleted(bool _completed) public {
    completed = _completed;
  }
}
