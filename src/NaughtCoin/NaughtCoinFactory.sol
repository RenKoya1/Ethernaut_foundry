// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./NaughtCoin.sol";
import "../Level.sol";

contract NaughtCoinFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        NaughtCoin instance = new NaughtCoin(_player);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        NaughtCoin instance = NaughtCoin(payable(_instance));
        return instance.balanceOf(_player) == 0;
    }
}
