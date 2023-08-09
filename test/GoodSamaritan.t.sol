// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/GoodSamaritan/GoodSamaritan.sol";
import "../src/GoodSamaritan/GoodSamaritanFactory.sol";
import "../src/GoodSamaritan/GoodSamaritanHack.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://medium.com/@0xkmg/ethernaut-27-good-samaritan-walkthrough-5555f27393f8

contract GoodSamaritanTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testGatekeeper() public {
        GoodSamaritanFactory factory = new GoodSamaritanFactory();
        address instance = factory.createInstance(_alice);
        GoodSamaritanHack hack = new GoodSamaritanHack();
        hack.attack(instance);
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
