// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Privacy.sol";
import "../Level.sol";

contract PrivacyFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        bytes32[3] memory data;
        data[0] = keccak256(abi.encodePacked(tx.origin, "0"));
        data[1] = keccak256(abi.encodePacked(tx.origin, "1"));
        data[2] = keccak256(abi.encodePacked(tx.origin, "2"));
        Privacy instance = new Privacy(data);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        Privacy instance = Privacy(payable(_instance));
        return !instance.locked();
    }
}
