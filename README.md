# eth-pool

[![License](https://img.shields.io/:license-mit-blue.svg)](https://rootulp.mit-license.org)

EthPool is a learning exercise motivated by this [challenge](./challenge.md). The goal is to write a contract (named "EthPool") that allows users to deposit and withdraw ETH from. Occasionally, a pool operator will deposit rewards (also denominated in ETH) into the pool. Rewards are distributed to depositors based on their percentage share of the pool.

## Examples

### Example 1
1. Alice deposits 1 ETH.
1. Bob deposits 1 ETH.
1. Operator deposits 1 ETH of rewards in the pool. Since Alice and Bob both have 50% ownership of the pool, they both receive 50% of the rewards (.5 ETH).
1. Alice can withdraw 1.5 ETH and Bob can withdraw 1.5 ETH.

### Example 2

1. Alice deposits 1 ETH.
1. Bob deposits 3 ETH.
1. Operator deposits 1 ETH of rewards in the pool. Alice recieves .25 ETH and Bob receives .75 ETH.
1. Alice can withdraw 1.25 ETH and Bob can withdraw 3.75 ETH.

## Local Development

### Prerequisites

1. Clone this repo
1. Create a project on [Alchemy](https://www.alchemy.com/)
1. Create an API key on [Etherscan](https://etherscan.io/myapikey)

### Initial Setup

```sh
# Install git submodule dependencies
forge install

# Copy the default .env file
cp .env.default .env

# Populate .env with ETH_RPC_URL from Alchemy and PRIVATE_KEY from a testnet wallet
vim .env

# Source the .env file
source .env
```

### Helpful Commands

```sh
# Build
forge build

# Test
forge test

# Deploy contract
forge create --rpc-url $ETH_RPC_URL --private-key $PRIVATE_KEY src/EthPool.sol:EthPool

# Verify on Etherscan
forge verify-contract --chain-id $CHAIN_ID --num-of-optimizations 200 --compiler-version $COMPILER_VERSION $CONTRACT_ADDRESS src/EthPool.sol:EthPool $ETHERSCAN_API_KEY
```

## Deployments

Network | Address
------- | -------
Goerli  | 0x69727e6c77dff8d16537887b8ebe0609f8548c35

## To-do

- [ ] Consider refactoring EthPool to not use a dynamically sized array

## Contribute

I'd appreciate any feedback via [issues](https://github.com/rootulp/eth-pool/issues/new).

## Acknowledgements

- https://github.com/gakonst/foundry
- https://github.com/OpenZeppelin/openzeppelin-contracts
