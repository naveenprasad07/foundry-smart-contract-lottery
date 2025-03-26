// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

contract CreateSubscription is Script {
    function createSubscriptionUsingConfig() public returns (uint256, address) {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinatorV2_5 = helperConfig.getConfig().vrfCoordinatorV2_5;
        (uint256 subId,) = createSubscription(vrfCoordinatorV2_5);

        return (subId, vrfCoordinatorV2_5);
    }

    function createSubscription(address vrfCoordinatorV2_5) public returns (uint256, address) {
        console.log("Creating a subscription on chain Id : ", block.chainid);
        vm.startBroadcast();
        uint256 subId = VRFCoordinatorV2_5Mock(vrfCoordinatorV2_5).createSubscription();
        vm.stopBroadcast();

        console.log("Your subscritpion Id is:", subId);
        console.log("Please Update the subscription Id in your HelperConfig.s.sol");
        return (subId, vrfCoordinatorV2_5);
    }

    function run() public {
        createSubscriptionUsingConfig();
    }
}
