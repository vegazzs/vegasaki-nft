//SPDX-License-Identiifier: MIT

pragma solidity ^0.8.19;

import{Vegasaki} from "../src/Vegasaki.sol";
import{Script} from "../lib/forge-std/src/Script.sol";
import{DevOpsTools} from "@foundry-devops/src/DevOpsTools.sol";

contract Interactions is Script{

    string public vegasakiBegin = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/0.json";
    string public vegasakiBlack = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/1.json";
    string public vegasakiGolden = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/2.json";
    string public vegasakiCyborg = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/3.json";
    string public vegasakiEternal = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/4.json";




    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("Vegasaki", block.chainid);
        mintNftOnContract(mostRecentDeployment);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        Vegasaki(mostRecentlyDeployed).mintNft(vegasakiEternal);
        vm.stopBroadcast();
    }

}