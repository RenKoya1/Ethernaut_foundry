// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import "../src/Telephone/Telephone.sol";
import "../src/Telephone/TelephoneFactory.sol";
import "../src/Telephone/TelephoneHack.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract TelephoneTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testTelephone() public {
        TelephoneFactory factory = new TelephoneFactory();
        assertEq(factory.owner(), address(this));

        address instance = factory.createInstance(_alice);
        Telephone telephone = Telephone(payable(instance));
        assertEq(telephone.owner(), address(factory));
        TelephoneHack hack = new TelephoneHack(instance);
        vm.prank(_alice, _alice); // msg.sender, tx.origin
        hack.attack();
        assertEq(telephone.owner(), _alice);
        assertTrue(
            factory.validateInstance(payable(instance), _alice),
            "invalid"
        );
    }
}
