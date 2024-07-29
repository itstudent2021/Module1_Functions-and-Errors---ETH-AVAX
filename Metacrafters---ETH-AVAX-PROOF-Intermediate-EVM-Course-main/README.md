## Functions and Errors

This is a contract with assert(), revert(), and require().

## Functions

### addGame

Creates and adds a new game to the store with an initial state of `Available`.

### startShipping

Initiates the shipping process for a game, transitioning its state to `InTransit`.

### completeDelivery

Marks the delivery of a game as complete, transitioning its state to `Delivered`. Reverts transactions if the game is already delivered or not yet in transit.

### assertGameState

Allows checking if a game is in a specific state.

### revertToAvailable

Reverts the state of a game back to `Available`, allowing for state reset if needed.

## Usage

### IDE

the contract was developed using Remix IDE. So, the entire project was developed using Remix.

### Compile

1. Open the Remix IDE and navigate to the "Solidity Compiler" tab.
2. Select the appropriate compiler version (e.g., 0.8.26).
3. Click on "Compile VideoGameStore.sol" to compile the contract.

### Deploy

1. Go to the "Deploy & Run Transactions" tab in Remix.
2. Select the VideoGameStore contract.
3. Click on "Deploy" to deploy the contract with the specified gas fee.
