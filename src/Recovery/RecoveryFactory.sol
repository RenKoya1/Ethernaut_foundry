// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Recovery.sol";
import "../Level.sol";

contract RecoveryFactory is Level {
    mapping(address => address) lostAddress;

    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Recovery instance = new Recovery();
        instance.generateToken("a", uint(10000));
        //fot test
        lostAddress[address(instance)] = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            uint8(0xd6),
                            uint8(0x94),
                            instance,
                            uint8(0x01)
                        )
                    )
                )
            )
        );
        (bool result, ) = lostAddress[address(instance)].call{
            value: 0.001 ether
        }("");
        require(result);

        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        return address(lostAddress[_instance]).balance == 0;
    }
}
