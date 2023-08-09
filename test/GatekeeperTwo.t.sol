// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/GatekeeperTwo/GatekeeperTwo.sol";
import "../src/GatekeeperTwo/GatekeeperTwoFactory.sol";
import "../src/GatekeeperTwo/GatekeeperTwoHack.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-13-solution-gatekeeper-one-7587bfb38550

contract GatekeeperTwoTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testGatekeeper() public {
        GatekeeperTwoFactory factory = new GatekeeperTwoFactory();
        address instance = factory.createInstance(_alice);
        vm.startPrank(_alice, _alice);
        GatekeeperTwoHack hack = new GatekeeperTwoHack(instance);
        hack;
        vm.stopPrank();
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
