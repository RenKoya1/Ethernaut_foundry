// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/Privacy/Privacy.sol";
import "../src/Privacy/PrivacyFactory.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-12-solution-privacy-b7589abb1d0f

contract PrivacyTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testPrivacy() public {
        PrivacyFactory factory = new PrivacyFactory();
        address instance = factory.createInstance(_alice);

        bytes16 key = bytes16(vm.load(instance, bytes32(uint256(5))));
        assertTrue(Privacy(instance).locked());
        Privacy(instance).unlock(key);

        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
