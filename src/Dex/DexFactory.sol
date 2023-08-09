// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../Level.sol";
import "./Dex.sol";

contract DexFactory is Level {
    address _alice;

    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Dex instance = new Dex();
        SwappableToken token1 = new SwappableToken(
            address(instance),
            "Token 1",
            "T1",
            110
        );
        SwappableToken token2 = new SwappableToken(
            address(instance),
            "Token 2",
            "T2",
            110
        );
        address token1Address = address(token1);
        address token2Address = address(token2);
        instance.setTokens(token1Address, token2Address);

        token1.approve(address(instance), 100);
        token2.approve(address(instance), 100);
        instance.addLiquidity(token1Address, 100);
        instance.addLiquidity(token2Address, 100);
        token1.transfer(_player, 10);
        token2.transfer(_player, 10);

        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        address token1Address = Dex(_instance).token1();
        address token2Address = Dex(_instance).token2();

        return
            IERC20(token1Address).balanceOf(_instance) == 0 ||
            IERC20(token2Address).balanceOf(_instance) == 0;
    }
}
