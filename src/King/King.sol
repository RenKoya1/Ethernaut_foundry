// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ref https://stermi.medium.com/the-ethernaut-challenge-9-solution-king-ee9a689bcf0e

contract King {
    address king;
    uint public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}
