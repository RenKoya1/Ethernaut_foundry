// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./Force.sol";
import "../Level.sol";

contract ForceFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Force instance = new Force();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        Force instance = Force(payable(_instance));
        return address(instance).balance > 0;
    }
}
