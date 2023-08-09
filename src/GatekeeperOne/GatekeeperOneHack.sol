// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./GatekeeperOne.sol";

contract GatekeeperOneHack {
    function attack(address instance, bytes8 key) public {
        bool result = GatekeeperOne(instance).enter(key);
        require(result, "failed");
    }
}
