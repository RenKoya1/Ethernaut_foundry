// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Denial.sol";
import "../Level.sol";
import "forge-std/console.sol";

contract DenialFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Denial instance = new Denial();
        (bool result, ) = address(instance).call{value: msg.value}("");
        require(result);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public override returns (bool) {
        _player;
        (bool result, ) = _instance.call{gas: 1000000}(
            abi.encodeWithSignature("withdraw()")
        );
        return !result;
    }
}
