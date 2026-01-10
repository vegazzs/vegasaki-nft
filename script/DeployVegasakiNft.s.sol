//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import{Script} from "../lib/forge-std/src/Script.sol";
import{Vegasaki} from "../src/Vegasaki.sol";

contract DeployVegasaki is Script{

    function run() external returns(Vegasaki) {
        vm.startBroadcast();
        Vegasaki vegasaki = new Vegasaki();
        vm.stopBroadcast();

        return vegasaki;
    }
}