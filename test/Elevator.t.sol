// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/Elevator/Elevator.sol";
import "../src/Elevator/ElevatorFactory.sol";
import "../src/Elevator/ElevatorHack.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ElevatorTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testElevator() public {
        ElevatorFactory factory = new ElevatorFactory();
        address instance = factory.createInstance(_alice);

        ElevatorHack hack = new ElevatorHack();
        assertTrue(!Elevator(instance).top());
        hack.attack(instance);
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
