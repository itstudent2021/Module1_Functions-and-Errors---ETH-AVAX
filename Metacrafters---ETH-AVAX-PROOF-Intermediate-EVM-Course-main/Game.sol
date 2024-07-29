// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract VideoGameStore {
    // Enum to represent the different states of a game
    enum State { Available, InTransit, Delivered }
    
    // Struct to store game details
    struct Game {
        uint id; // Game ID
        string name; // Game name
        State state; // Current state of the game
        address owner; // Owner of the game
    }
    
    // Mapping to store games with their IDs
    mapping(uint => Game) public games;
    
    // Counter for game IDs
    uint public gameCount;

    // Event to log state changes of a game
    event GameStateChanged(uint gameId, State state);

    // Modifier to check if the caller is the owner of the game
    modifier onlyGameOwner(uint gameId) {
        require(gameId <= gameCount, "Game does not exist");
        require(msg.sender == games[gameId].owner, "Not the game owner");
        _;
    }

    // Function to add a new game
    function addGame(string memory name) public {
        gameCount++; // Increment the game count
        games[gameCount] = Game(gameCount, name, State.Available, msg.sender); // Add the new game to the mapping
        emit GameStateChanged(gameCount, State.Available); // Emit event for state change
    }

    // Function to start shipping a game
    function startShipping(uint gameId) public onlyGameOwner(gameId) {
        Game storage game = games[gameId]; // Get the game from the mapping
        require(game.state == State.Available, "Game must be 'Available' to start shipping"); // Check if the game is in 'Available' state
        
        game.state = State.InTransit; // Change the state to 'InTransit'
        emit GameStateChanged(gameId, State.InTransit); // Emit event for state change
    }

    // Function to complete the delivery of a game
    function completeDelivery(uint gameId) public onlyGameOwner(gameId) {
        Game storage game = games[gameId]; // Get the game from the mapping
        if (game.state == State.Available) {
            revert("Game should be in transit for it to be delivered");
        } else if (game.state == State.Delivered) {
            revert("Game has already been delivered");
        } else {
            game.state = State.Delivered; // Change the state to 'Delivered'
            emit GameStateChanged(gameId, State.Delivered); // Emit event for state change
        }
    }

    // Function to assert that a game is in an expected state
    function assertGameState(uint gameId, State expectedState) public view {
        Game storage game = games[gameId]; // Get the game from the mapping
        assert(game.state == expectedState); // Assert that the game is in the expected state
    }

    // Function to revert the game state to 'Available'
    function revertToAvailable(uint gameId) public onlyGameOwner(gameId) {
        Game storage game = games[gameId]; // Get the game from the mapping
        require(game.state != State.Available, "Game is already in 'Available' state"); // Check if the game is not in 'Available' state
        game.state = State.Available; // Change the state to 'Available'
        emit GameStateChanged(gameId, State.Available); // Emit event for state change
    }
}
