// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Fallback.sol";
import "../Level.sol";

contract FallbackFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player; // nothing to do
        Fallback instance = new Fallback();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        Fallback instance = Fallback(_instance);
        return instance.owner() == _player && address(instance).balance == 0;
    }
}
