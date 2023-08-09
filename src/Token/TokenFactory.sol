// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./Token.sol";
import "../Level.sol";

contract TokenFactory is Level {
    uint256 initialSupply = 10000000;
    uint256 playerSupply = 20;

    function createInstance(
        address _player
    ) public payable override returns (address) {
        Token instance = new Token(initialSupply);
        instance.transfer(_player, playerSupply);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        Token instance = Token(payable(_instance));
        return instance.balanceOf(_player) > playerSupply;
    }
}
