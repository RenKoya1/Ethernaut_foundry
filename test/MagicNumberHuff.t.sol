// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import "../src/MagicNumber/MagicNumber.sol";
import "../src/MagicNumber/MagicNumberFactory.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract MagicNumberTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testMagicNumber() public {
        MagicNumberFactory factory = new MagicNumberFactory();
        address solveInstance = HuffDeployer.deploy(
            "MagicNumber/MagicNumberSolver"
        );
        assertEq(
            Solver(solveInstance).whatIsTheMeaningOfLife(),
            bytes32(uint256(0x2a)),
            "failed"
        );

        address instance = factory.createInstance(_alice);
        MagicNum(instance).setSolver(solveInstance);
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
