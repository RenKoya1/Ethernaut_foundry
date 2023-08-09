// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/King/King.sol";
import "../src/King/KingFactory.sol";
import "../src/King/KingHack.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract KingTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testKing() public {
        KingFactory factory = new KingFactory();
        address instance = factory.createInstance{value: 1 ether}(_alice);
        assertEq(King(payable(instance))._king(), address(factory));
        KingHack hack = new KingHack{value: 1 ether}(payable(instance));
        hack;
        assertEq(King(payable(instance))._king(), address(hack));
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
