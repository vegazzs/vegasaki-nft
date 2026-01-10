# ⚔️VEGASAKI-SHOGUN NFT COLLECTION⚔️

<img width="960" height="1088" alt="2" src="https://github.com/user-attachments/assets/3ce8e321-f49a-4f60-ab61-236935369db9" />

### About
 A professional-grade, gas-optimized ERC-721 NFT collection built with Foundry. This project demonstrates advanced Solidity patterns, including custom error handling, on-chain uniqueness guarantees, and automated testing.

### Overview
Vegasaki is designed with Immutable Scarcity at its core. Unlike standard NFT implementations, this contract physically prevents the owner from accidentally minting duplicate metadata or empty tokens, ensuring the integrity of the collection.

### Key Features
    -On-Chain Uniqueness: Implements keccak256 hashing of tokenURI to prevent duplicate minting of the same metadata.
    -Safety Rails: Built-in checks to prevent minting NFTs with empty metadata strings.
    -Owner Controlled: Fully compatible with OpenZeppelin's Ownable for secure management.

### 🚀Getting Started

#### Prerequisites
[Install Foundry](https://book.getfoundry.sh/getting-started/installation)

#### Installation
    Bash

    git clone https://github.com/vegazzs/vegasaki-nft
    cd nft-vegas
    forge install

#### Build & Test
    Bash

    make build
    make test

#### Deployment (Local Anvil)
    1. Start Anvil:

        Bash

        make anvil

    2. Deploy & Mint:

        Bash
        
        make deploy
        make mint

### 🧪Testing Suite

The project includes a robust testing suite in VagasakiTest.t.sol covering:

    1. Successful Minting: Validates state changes and ownership.
    2. Duplicate Prevention: Ensures the contract reverts if the same URI is used twice.
    3. Input Validation: Ensures the contract reverts on empty strings.
