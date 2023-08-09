// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/Token/Token.sol";
import "../src/Token/TokenFactory.sol";

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract TokenTest is Test {
    address _alice;
    uint256 initialSupply = 10000000;
    uint256 playerSupply = 20;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testToken() public {
        TokenFactory factory = new TokenFactory();
        assertEq(factory.owner(), address(this));

        address instance = factory.createInstance(_alice);
        Token token = Token(payable(instance));
        assertEq(
            token.balanceOf(address(factory)),
            initialSupply - playerSupply
        );
        assertEq(token.balanceOf(address(_alice)), playerSupply);
        vm.prank(_alice, _alice); // msg.sender, tx.origin
        token.transfer(_alice, 21);
        console.log(token.balanceOf(address(_alice)));
        // vm.prank(_alice, _alice); // msg.sender, tx.origin
        // token.transfer(_alice, 1 ether);
        // assertEq(token.balanceOf(_alice), 1 ether);
        // assertTrue(
        //     factory.validateInstance(payable(instance), _alice),
        //     "invalid"
        // );
    }
}
