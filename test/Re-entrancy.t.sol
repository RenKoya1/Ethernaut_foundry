// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/Re-entrancy/Re-entrancy.sol";
import "../src/Re-entrancy/Re-entrancyFactory.sol";
import "../src/Re-entrancy/Re-entrancyHack.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ReentranceTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testReentrance() public {
        ReentranceFactory factory = new ReentranceFactory();
        address instance = factory.createInstance{value: 1 ether}(_alice);
        assertEq(instance.balance, 1 ether);
        ReentranceHack hack = new ReentranceHack(payable(instance));
        hack.attack{value: 1 ether}();
        console.log("balance", address(hack).balance);
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
