// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../Level.sol";
import "./GatekeeperThree.sol";
import "forge-std/console.sol";

contract GatekeeperThreeFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        GatekeeperThree instance = new GatekeeperThree();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        return GatekeeperThree(_instance).entrant() == _player;
    }
}
