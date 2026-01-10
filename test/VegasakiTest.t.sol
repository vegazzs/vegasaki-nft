//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import{Test, console2} from "../lib/forge-std/src/Test.sol";
import{Vegasaki} from "../src/Vegasaki.sol";
import{DeployVegasaki} from "../script/DeployVegasakiNft.s.sol";

contract VegasakiTest is Test{
    Vegasaki vegasaki;
    DeployVegasaki deployer;

    string public vegasakiBegin = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/0.json";
    string public vegasakiBlack = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/1.json";
    string public vegasakiGolden = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/2.json";
    string public vegasakiCyborg = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/3.json";
    string public vegasakiEternal = "ipfs://bafybeihdavyyietihutnrol7s2mw564xis2tasj7evm7tkw6idm6mxjbpe/4.json";

    address public VEGAS = makeAddr("VEGAS");
    address public JULZ = makeAddr("JULZ");



    function setUp() external {
        deployer = new DeployVegasaki();
        vegasaki = deployer.run();
    }

    //THIS TEST ENSURES THE NFT NAME RETURNS AS EXPECTED
    function testNftNameReturnsExpected() public view {
        string memory expectedName = "VEGASAKI";
        string memory actualName = vegasaki.name();

        assertEq(actualName, expectedName);
    }

    //THIS TEST ENSURE THE NFT SYMBOL RETURNS AS EXPECTED 
    function testNftSymbolReturnsExpected() public view {
        string memory expectedSym = "VGS";
        string memory actualSym = vegasaki.symbol();

        assertEq(actualSym, expectedSym);
    }

    //A MODIFIER TO MAKE TESTING EASIER
    modifier minted(){
        vm.prank(msg.sender);
        vegasaki.mintNft(vegasakiBegin);
        _;
    }

    //THIS IS A SECURITY CHECK FOR THE OPENZEPPELIN OWNABLE
    function testNotOwnerCantMint() public {
        vm.prank(VEGAS);
        vm.expectRevert();
        vegasaki.mintNft(vegasakiBegin);
    }

    //SHOWS ONLY OWNER CAN MINT NFT
    function testOwnerCanMint() public {
        vm.prank(msg.sender);
        vegasaki.mintNft(vegasakiBegin);
    }

    //THIS TEST CHECKS THAT TOKEN ID RETURNS THE EXPECTED URI
    function testTokenIdReturnsExpectedUri() public minted {
        //ACT
        string memory IdToUri = vegasaki.tokenURI(0);
        //ASSERT
        assertEq(IdToUri, vegasakiBegin);
    }

    //TEST THAT BALANCE OF OWNER UPDATES AFTER MINTING AND TOKEN COUNTER ADDS
    function testBalanceOfOwnerUpdatesOnMintingAndTokenCounterUpdates() public {
        //ACT
        vm.prank(msg.sender);
        vegasaki.mintNft(vegasakiBegin);
        vm.prank(msg.sender);
        vegasaki.mintNft(vegasakiBlack);
        vm.prank(msg.sender);
        vegasaki.mintNft(vegasakiGolden);

        //ASSERT
        uint256 balance = vegasaki.balanceOf(msg.sender);
        uint256 tokenCounter = vegasaki.getNumberOfMintedTokens();
        assertEq(balance, 3);
        assertEq(tokenCounter, 3);
    }

    //TEST ENSURES APPROVING AN ADDRESS WORKS
    function testApproveWorks() public minted{
        //Aprrove VEGAS with Token(0)
        vm.prank(msg.sender);
        vegasaki.approve(VEGAS, 0);

        //Assert that VEGAS is an approved address
        address approved = vegasaki.getApproved(0);
        assertEq(approved, VEGAS);

        //Let VEGAS transfer Token(0) from owner to another address(JULZ)
        vm.prank(VEGAS);
        vegasaki.safeTransferFrom(msg.sender, JULZ, 0);

        //Assert that JULZ is now the new Owner of token(0)
        address owner = vegasaki.ownerOf(0);
        assertEq(owner, JULZ);

        //Assert that VEGAS is no longer approved for this token(0)
        vm.prank(VEGAS);
        vm.expectRevert();
        vegasaki.safeTransferFrom(msg.sender, JULZ, 0);
    }

    function testOwnerCantMintSameUriTwiceOrEmptyUri() public minted{
        vm.prank(msg.sender);
        vm.expectRevert();
        vegasaki.mintNft(vegasakiBegin);

        vm.prank(msg.sender);
        vm.expectRevert();
        vegasaki.mintNft("");

    }

    function testUri() public {
        vm.prank(msg.sender);
        vegasaki.mintNft(vegasakiEternal);
    }

   
}