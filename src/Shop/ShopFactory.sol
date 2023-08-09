// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Shop.sol";
import "../Level.sol";

contract ShopFactory is Level {
    address _alice;

    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Shop instance = new Shop();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        bool result = Shop(_instance).isSold();
        return result;
    }
}
