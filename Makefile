-include .env

.PHONY: clean update anvil deploy test test-zksync deploy fund help snapshot

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

all: clean remove install update build

clean :; forge clean 

install :; forge install

update:; forge update

build :; forge build

anvil:;  anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy-anvil:;forge script script/DeployVegasakiNft.s.sol:DeployVegasaki --broadcast --rpc-url http://localhost:8545  --private-key $(DEFAULT_ANVIL_KEY)   -vvvv 

deploy-sepolia:; forge script script/DeployVegasakiNft.s.sol:DeployVegasaki --rpc-url  $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --etherscan-api-key $(ETHERSCAN_API_KEY) --broadcast --verify

zktest :; foundryup-zksync && forge test --zksync && foundryup

test :; forge test

verbose:; forge test -vvvv

mint-anvil:; forge script script/Interactions.s.sol:Interactions --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast

mint-sepolia:; forge script script/Interactions.s.sol:Interactions --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast