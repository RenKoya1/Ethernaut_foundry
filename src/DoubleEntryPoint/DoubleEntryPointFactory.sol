// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../Level.sol";
import "./DoubleEntryPoint.sol";
import "forge-std/console.sol";

contract DoubleEntryPointFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        LegacyToken legacy = new LegacyToken();
        Forta forta = new Forta();
        CryptoVault vault = new CryptoVault(_player);

        DoubleEntryPoint instance = new DoubleEntryPoint(
            address(legacy),
            address(vault),
            address(forta),
            _player
        );
        vault.setUnderlying(address(instance));
        legacy.delegateToNewContract(DelegateERC20(address(instance)));
        legacy.mint(address(vault), 100 ether);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public override returns (bool) {
        DoubleEntryPoint instance = DoubleEntryPoint(_instance);
        Forta forta = instance.forta();
        address usersDetectionBot = address(forta.usersDetectionBots(_player));
        if (usersDetectionBot == address(0)) return false;

        address vault = instance.cryptoVault();
        CryptoVault cryptoVault = CryptoVault(vault);

        (bool ok, bytes memory data) = _trySweep(cryptoVault, instance);

        require(!ok, "Sweep succeded");

        bool swept = abi.decode(data, (bool));
        return swept;
    }

    function _trySweep(
        CryptoVault cryptoVault,
        DoubleEntryPoint instance
    ) internal returns (bool, bytes memory) {
        try cryptoVault.sweepToken(IERC20(instance.delegatedFrom())) {
            return (true, abi.encode(false));
        } catch {
            return (
                false,
                abi.encode(instance.balanceOf(instance.cryptoVault()) > 0)
            );
        }
    }
}
