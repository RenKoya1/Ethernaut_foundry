// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./GoodSamaritan.sol";
import "../Level.sol";

contract GoodSamaritanFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        GoodSamaritan instance = new GoodSamaritan();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        Wallet wallet = GoodSamaritan(_instance).wallet();
        Coin coin = GoodSamaritan(_instance).coin();

        return coin.balances(address(wallet)) == 0;
    }
}
