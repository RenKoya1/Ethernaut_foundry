// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../Level.sol";
import "./King.sol";

contract KingFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        require(msg.value >= 1 ether, "send at least 1 ETH");
        King instance = new King{value: msg.value}();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        King instance = King(payable(_instance));
        return instance._king() != address(this);
    }

    // attention
    receive() external payable {}
}
