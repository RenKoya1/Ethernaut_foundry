// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../Level.sol";
import "./Motorbike.sol";

contract MotorbikeFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Engine engine = new Engine(); //implements

        Motorbike instance = new Motorbike(address(engine)); //proxy

        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        return !Address.isContract(_instance); //_instance = engine
    }
}
