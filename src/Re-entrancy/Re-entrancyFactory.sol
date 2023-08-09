// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./Re-entrancy.sol";
import "../Level.sol";

contract ReentranceFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Reentrance instance = new Reentrance();
        payable(address(instance)).transfer(msg.value);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        Reentrance instance = Reentrance(payable(_instance));
        console.log("ans", address(instance).balance);
        return address(instance).balance == 0;
    }
}
