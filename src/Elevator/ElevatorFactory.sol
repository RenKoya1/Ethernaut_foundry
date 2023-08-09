// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Elevator.sol";
import "../Level.sol";

contract ElevatorFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Elevator instance = new Elevator();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        Elevator instance = Elevator(payable(_instance));
        return instance.top();
    }
}
