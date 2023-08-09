// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/DoubleEntryPoint/DoubleEntryPoint.sol";
import "../src/DoubleEntryPoint/DetectionBot.sol";
import "../src/DoubleEntryPoint/DoubleEntryPointFactory.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-24-solution-double-entry-point-138d88196a

contract DoubleEntryPointTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testDoubleEntryPoint() public {
        DoubleEntryPointFactory factory = new DoubleEntryPointFactory();
        address instance = factory.createInstance(_alice);
        vm.startPrank(_alice);
        DetectionBot bot = new DetectionBot();
        Forta forta = Forta(DoubleEntryPoint(instance).forta());
        forta.setDetectionBot(address(bot));
        assertEq(
            address(bot),
            address(forta.usersDetectionBots(address(_alice)))
        );
        bot.setFortaAddress(address(forta));
        vm.stopPrank();
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
