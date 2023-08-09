// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../src/Force/Force.sol";
import "../src/Force/ForceFactory.sol";
import "../src/Force/ForceHack.sol";
import {Test} from "forge-std/Test.sol";

contract ForceTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testeForce() public {
        ForceFactory factory = new ForceFactory();
        address instance = factory.createInstance(_alice);
        ForceHack forceHack = new ForceHack{value: 1 ether}(payable(instance));
        forceHack;
        assertTrue(
            factory.validateInstance(payable(instance), _alice),
            "invalid"
        );
    }
}
