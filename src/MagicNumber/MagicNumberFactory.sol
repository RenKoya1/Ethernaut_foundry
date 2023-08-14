// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./MagicNumber.sol";
import "../Level.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-18-solution-magic-number-2cb8edee383a
// https://solidity-by-example.org/app/simple-bytecode-contract/

interface Solver {
    function whatIsTheMeaningOfLife() external view returns (bytes32);
}

contract MagicNumberFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        MagicNum instance = new MagicNum();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        _player;
        MagicNum instance = MagicNum(_instance);
        Solver solver = Solver(instance.solver());
        console.log(address(solver));
        bytes32 magic = solver.whatIsTheMeaningOfLife();
        console.log(uint(magic));
        if (
            magic !=
            0x000000000000000000000000000000000000000000000000000000000000002a //42
        ) return false;

        // Require the solver to have at most 10 opcodes.
        uint256 size;
        assembly {
            size := extcodesize(solver)
        }
        if (size > 10) return false;
        return true;
    }
}
