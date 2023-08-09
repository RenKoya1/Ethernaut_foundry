// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../src/Recovery/Recovery.sol";
import "../src/Recovery/RecoveryFactory.sol";
import "forge-std/Test.sol";

// ref https://stermi.medium.com/the-ethernaut-challenge-17-solution-recovery-aeb3c44310bf
// https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed/761#761

contract RecoveryTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testRecovery() public {
        RecoveryFactory factory = new RecoveryFactory();
        address recoveryAddress = factory.createInstance{value: 0.001 ether}(
            _alice
        );
        //The address for an Ethereum contract is deterministically computed from the address of its creator (sender) and how many transactions the creator has sent (nonce). The sender and nonce are RLP encoded and then hashed with Keccak-256.

        // contract's nonce start from 1
        //nonce0= address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), _origin, bytes1(0x80))))));
        //nonce1= address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), _origin, bytes1(0x01))))));
        address sampleAddress = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            uint8(0xd6),
                            uint8(0x94),
                            recoveryAddress,
                            uint8(0x01)
                        )
                    )
                )
            )
        );

        SimpleToken sample = SimpleToken(payable(sampleAddress));
        sample.destroy(payable(address(0)));

        factory.validateInstance(payable(recoveryAddress), _alice);
    }
}
