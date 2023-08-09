// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

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

    /*
     [00] PUSH1 2a 
     [02] PUSH1 00
     [04] MSTORE  //store 2a(42) in 00
     [05] PUSH1 20
     [07] PUSH1 00
     [09] RETURN  // return 0x20(32) bytes from 00
    -> bytecode = 0x602A60005260206000F3

    [00] PUSH10 602A60005260206000F3 // 10bytes
    [0b] PUSH1 00
    [0d] MSTORE  //store 602A60005260206000F3 in 00
    [0e] PUSH1 0A
    [10] PUSH1 16
    [12] RETURN // return 0x0a(10) bytes from 0x16(22) 
    -> bytescode = 0x69602A60005260206000F3600052600A6016F3

    */
    function testMagicNumber() public {
        MagicNumberFactory factory = new MagicNumberFactory();
        address solveInstance;
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3"; //size = 19(0x13)bytes
        assembly {
            //first 32bytes is length of the array so skip
            solveInstance := create(0, add(bytecode, 0x20), 0x13) // create(value, pointer, size) create new contract with code mem[p…(p+n)) and send v wei and return the new address; returns 0 on error
        }
        address instance = factory.createInstance(_alice);
        MagicNum(instance).setSolver(solveInstance);
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
