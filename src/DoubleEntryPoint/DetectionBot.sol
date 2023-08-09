// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./DoubleEntryPoint.sol";

contract DetectionBot is IDetectionBot {
    address _fortaAddress;

    function setFortaAddress(address fortaAddress_) public {
        _fortaAddress = fortaAddress_;
    }

    function handleTransaction(address user, bytes calldata) external {
        Forta forta = Forta(_fortaAddress);
        forta.raiseAlert(user);
    }
}
