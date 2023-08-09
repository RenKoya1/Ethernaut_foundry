// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./AlienCodex.sol";
import "forge-std/Test.sol";
import "../Level.sol";

contract AlienCondexFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        AlienCodex instance = new AlienCodex();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        AlienCodex instance = AlienCodex(payable(_instance));
        return instance.owner() == _player;
    }
}
