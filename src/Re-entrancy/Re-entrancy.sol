// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "forge-std/console.sol";

contract Reentrance {
    mapping(address => uint) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to] + msg.value;
    }

    function balanceOf(address _who) public view returns (uint balance) {
        return balances[_who];
    }

    function withdraw(uint _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            console.log(balances[msg.sender], _amount);
            balances[msg.sender] -= _amount; // ^0.8 occor underflow
        }
    }

    receive() external payable {}
}
