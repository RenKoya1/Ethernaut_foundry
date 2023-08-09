// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../Level.sol";
import "./Delegation.sol";

contract DelegationFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        Delegate delegate = new Delegate(_player);
        Delegation instance = new Delegation(address(delegate));
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        Delegation instance = Delegation(payable(_instance));
        return instance.owner() == _player;
    }
}
