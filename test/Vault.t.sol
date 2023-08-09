// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../src/Vault/Vault.sol";
import "../src/Vault/VaultFactory.sol";
import {Test} from "forge-std/Test.sol";

contract VaultTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testVault() public {
        VaultFactory factory = new VaultFactory();
        address instance = factory.createInstance(_alice);
        Vault(instance).unlock(vm.load(instance, bytes32(uint256(1))));
        assertTrue(
            factory.validateInstance(payable(instance), _alice),
            "invalid"
        );
    }
}
