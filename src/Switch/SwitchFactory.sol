// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../Level.sol";
import "./Switch.sol";
import "forge-std/console.sol";

contract SwitchFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Switch instance = new Switch();

        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        return Switch(_instance).switchOn();
    }
}
