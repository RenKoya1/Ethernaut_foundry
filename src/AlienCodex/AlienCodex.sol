// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Ownable-08.sol";

contract AlienCodex is Ownable08 {
    bool public contact;
    bytes32[] public codex;

    modifier contacted() {
        assert(contact);
        _;
    }

    function make_contact() public {
        contact = true;
    }

    function record(bytes32 _content) public contacted {
        codex.push(_content);
    }

    function retract() public contacted {
        // codex.length--;// ^0.8 cannot underflow
    }

    function revise(uint256 i, bytes32 _content) public contacted {
        codex[i] = _content;
    }
}
