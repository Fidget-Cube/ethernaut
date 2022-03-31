// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Bank {
  bool public completed = false;
  mapping(address => uint) public balances;
  
  function deposit() external payable {
    balances[msg.sender] += msg.value;
  }

  function withdraw() public {
    require(balances[msg.sender] > 0, "Insufficient funds");

    uint amount = balances[msg.sender];
    balances[msg.sender] = 0;

    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent, "Failed to send Ether");

    completed = true;
  }
}