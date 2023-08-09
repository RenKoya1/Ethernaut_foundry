// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./CoinFlip.sol";
import "../Level.sol";

contract CoinFlipFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player; // nothing to do
        CoinFlip instance = new CoinFlip();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        CoinFlip instance = CoinFlip(_instance);
        return instance.consecutiveWins() >= 10;
    }
}
