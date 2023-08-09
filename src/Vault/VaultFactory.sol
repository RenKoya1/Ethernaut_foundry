// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../Level.sol";
import "./Vault.sol";

contract VaultFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        bytes32 password = "password";
        Vault instance = new Vault(password);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        Vault instance = Vault(payable(_instance));
        return instance.locked() == false;
    }
}
