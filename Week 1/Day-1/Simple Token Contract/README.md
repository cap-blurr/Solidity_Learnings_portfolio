# Simple Token Contract
## Overview
This project implements a basic ERC20-like token on the Ethereum blockchain using Solidity. The contract, named SimpleToken, demonstrates fundamental concepts of token creation and management, including minting, transferring, and delegating token spending permissions.

## Contract Features

**Token Metadata**: The contract stores basic information about the token:

- Name
- Symbol
- Decimals (for token divisibility)


**Total Supply Management**: Tracks the total number of tokens in circulation.
**Balance Tracking**: Uses a mapping to associate Ethereum addresses with their token balances.
**Token Transfers**: Allows token holders to send tokens to other addresses.
**Delegated Transfers**: Implements an approval system for addresses to spend tokens on behalf of the token holder.

## Solidity Concepts Used
### State Variables
The contract uses several state variables to store critical information:
```
solidityCopystring public name;
string public symbol;
uint8 public decimals;
uint256 public totalSupply;
mapping(address => uint256) public balanceOf;
mapping(address => mapping(address => uint256)) public allowance;
```
using different data types ```(string, uint8, uint256)``` and more complex data structures like nested mappings.

### Constructor
The contract uses a constructor to initialize the token's properties:
```
solidityCopyconstructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
    // Initialization logic
}
```
shows how to set up a contract's initial state and the use of function parameters.

### Functions
The contract implements several functions such as:

- **transfer**: Demonstrates direct value transfer and error handling.
- **approve**: Shows how to update nested mappings and emit events.
- **transferFrom**: Illustrates a more complex function with multiple checks and state changes.

### Events
The contract defines and emits events for important state changes:
```
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
```

### Error Handling
The contract uses require statements for input validation and error handling:
```
require(balanceOf[msg.sender] >= _value, "Insufficient balance");
```

### Deployment and Interaction
To deploy this contract:

Compile the contract using a Solidity compiler (version 0.8.0 or higher).
Deploy to your chosen Ethereum network (e.g., Sepolia testnet)
When deploying, provide values for:

- Token Name
- Token Symbol
- Number of Decimals
- Initial Supply



After deployment, interact with the contract by:

- Calling ```transfer``` to send tokens
- Using ```approve``` and ```transferFrom``` for delegated transfers
- Checking balances with the ```balanceOf``` function


## Security Considerations

- This is a learning project and has not been audited for production use, so please don't be dumb and deploy this to a mainnet.
- It lacks advanced features like minting, burning, or pausing.
- Always exercise caution when approving addresses to spend tokens on your behalf.

## Future Improvements
Potential enhancements to explore:

- Implement minting and burning functions
- Add access control for administrative functions
- Introduce a mechanism to pause transfers in case of emergencies
