# eth-pool

[![License](https://img.shields.io/:license-mit-blue.svg)](https://rootulp.mit-license.org)

EthPool is a learning exercise motivated by this [challenge](./challenge.md). The goal is to write a contract (named "EthPool") that allows users to deposit and withdraw ETH from. Ocasionally, a pool operator will deposit rewards (also denominated in ETH) into the pool. Rewards are distributed to depositors based on their percentage share of the pool.

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

1. Clone this repo
1. Install git submodule dependencies: `forge install`

### Helpful Commands

```sh
forge build
forge test
```

## To-do

- [ ] Add fuzz tests
- [ ] Add natspec comments
- [ ] Consider refactoring EthPool to not use a dynamically sized array
- [ ] Deploy contract to testnet
- [ ] Verify on Etherscan

## Contribute

I'd appreciate any feedback via [issues](https://github.com/rootulp/eth-pool/issues/new).

## Acknowledgements

- https://github.com/gakonst/foundry
- https://github.com/OpenZeppelin/openzeppelin-contracts
