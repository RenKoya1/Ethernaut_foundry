// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../src/Shop/Shop.sol";
import "../src/Shop/ShopFactory.sol";
import "../src/Shop/ShopHack.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract ShopTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testShop() public {
        ShopFactory factory = new ShopFactory();
        address instance = factory.createInstance(_alice);
        ShopHack hack = new ShopHack(instance);
        hack.attack();
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
