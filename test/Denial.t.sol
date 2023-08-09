// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../src/Denial/Denial.sol";
import "../src/Denial/DenialFactory.sol";
import "../src/Denial/DenialHack.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract DenialTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testDenial() public {
        DenialFactory factory = new DenialFactory();
        vm.prank(_alice);
        address instance = factory.createInstance{value: 1 ether}(_alice);
        assertEq(address(instance).balance, 1 ether);
        DenialHack hack = new DenialHack(payable(instance));
        assertEq(address(hack), Denial(payable(instance)).partner());

        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
