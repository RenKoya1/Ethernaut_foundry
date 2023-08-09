// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Fallout.sol";
import "../Level.sol";

contract FalloutFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player; // nothing to do
        Fallout instance = new Fallout();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        Fallout instance = Fallout(_instance);
        return instance.owner() == _player;
    }
}
