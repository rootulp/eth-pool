# eth-pool

[![License](https://img.shields.io/:license-mit-blue.svg)](https://rootulp.mit-license.org)

EthPool is a learning exercise that provides a pool for users to deposit into and earn rewards from. The pool operator will sporadically deposit rewards into the pool. Rewards are distributed to depositors proportional to their share of deposits in the pool.

Motivated by: https://github.com/edgeandnode/contracts-challenge/tree/exercise-4

## Examples

### Example 1
1. Alice deposits 1 ETH.
1. Bob deposits 1 ETH.
1. Operator deposits 1 ETH of rewards in the pool. Since Alice and Bob both have 50% ownership of the pool, they both receive 50% of the rewards (.5 ETH).

### Example 2

1. Alice deposits 1 ETH.
1. Bob deposits 3 ETH.
1. Operator deposits 1 ETH of rewards in the pool. Alice recieves .25 ETH and Bob receives .75 ETH.

## Local Development

1. Clone this repo

### Helpful Commands

```sh
# Install git submodule dependencies
forge install

forge build
forge test
```

## Credits

- https://github.com/gakonst/foundry
