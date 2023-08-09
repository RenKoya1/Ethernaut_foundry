// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/console.sol";

contract SimpleTrick {
    GatekeeperThree public target;
    address public trick;
    uint private _password = block.timestamp;

    constructor(address payable _target) {
        target = GatekeeperThree(_target);
    }

    function checkPassword(uint __password) public returns (bool) {
        if (__password == _password) {
            return true;
        }
        _password = block.timestamp;
        return false;
    }

    function trickInit() public {
        trick = address(this);
    }

    function trickyTrick() public {
        if (address(this) == msg.sender && address(this) != trick) {
            target.getAllowance(_password);
        }
    }
}

contract GatekeeperThree {
    address public owner;
    address public entrant;
    bool public allowEntrance;

    SimpleTrick public trick;

    function construct0r() public {
        owner = msg.sender;
    }

    modifier gateOne() {
        require(msg.sender == owner);
        require(tx.origin != owner);
        console.log("one");
        _;
    }

    modifier gateTwo() {
        require(allowEntrance == true);
        console.log("two");
        _;
    }

    modifier gateThree() {
        if (
            address(this).balance > 0.001 ether &&
            payable(owner).send(0.001 ether) == false
        ) {
            console.log("three");
            _;
        }
    }

    function getAllowance(uint __password) public {
        if (trick.checkPassword(__password)) {
            allowEntrance = true;
        }
    }

    function createTrick() public {
        trick = new SimpleTrick(payable(address(this)));
        trick.trickInit();
    }

    function enter() public gateOne gateTwo gateThree {
        entrant = tx.origin;
    }

    receive() external payable {}
}
