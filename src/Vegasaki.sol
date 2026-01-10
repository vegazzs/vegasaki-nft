//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
@title Vegasaki(The Collection)
@author Vegas (vegaszzs)
@dev This is a simple NFT collection by Vegas
*/
contract Vegasaki is ERC721, Ownable{

    error Vegasaki__TokenUriAlreadyMinted();
    error Vegasaki__TokenUriCantBeEmpty();

    //**STATE VARIABLES**

    uint256 private s_tokenCounter;
    //A mapping of a tokenUri to an ID.
    mapping(uint256 => string) private s_tokenIdToUri;
    //A mapping to track already minted URIs. this will prevent the accidental
    //minting of the same token Uri twice
    mapping(bytes32 => bool) private s_tokenUriMinted;

    //constructor
    constructor()ERC721("VEGASAKI", "VGS")Ownable(msg.sender){
        s_tokenCounter = 0;
    }

    /**@dev this function allows thee owner to mint a token Uri.. the checks ensures that
            owner cannot mint the same tokenUri twice causing duplication. it also ensures
            that OWNER cannot accidentally mint an empty token Uri
     */
    function mintNft(string memory tokenUri) public onlyOwner{
        if(bytes(tokenUri).length == 0){revert Vegasaki__TokenUriCantBeEmpty();}

        bytes32 uriHash = keccak256(abi.encodePacked(tokenUri));
        if(s_tokenUriMinted[uriHash]){revert Vegasaki__TokenUriAlreadyMinted();}

        s_tokenUriMinted[uriHash] = true;

        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    /**@dev This function returns a tokenURI for a minted tokenId */

    function tokenURI(uint256 tokenId) public view override returns(string memory){
        return s_tokenIdToUri[tokenId];
    }

    /**
    @dev A getter function to get the number of minted tokens
     */
    function getNumberOfMintedTokens() public view returns(uint256){
        return s_tokenCounter;
    }
}