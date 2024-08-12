# Time Locked Wallet Contract

## Overview
This project implements a Time Locked Wallet on the Ethereum blockchain using Solidity. The `TimeLockedWallet` contract enables users to deposit funds that can only be withdrawn after a specified unlock time. The contract demonstrates core concepts such as deposit handling, time-based locking, and secure fund withdrawal.

## Contract Features

- **Fund Depositing**: Users can deposit Ether into the wallet, which gets locked until the specified unlock time.
- **Time Locking**: Funds are locked and can only be withdrawn after a certain period defined by the `unlockTime`.
- **Withdrawal Mechanism**: Allows the owner to withdraw funds after the unlock time has passed.
- **Extend Lock Time**: The owner can extend the lock time if needed.
- **Balance and Lock Time Check**: Provides functions to check the current balance and the remaining time until funds can be withdrawn.

## Key Solidity Concepts Demonstrated

### State Variables
```solidity
address public owner;
uint256 public unlockTime;
uint256 public depositAmount; 
```

This demonstrates the use of state variables to track ownership, the unlock time, and the amount of funds deposited in the contract.

## Events
```
event Deposit(address indexed depositor, uint256 amount, uint256 unlockTime);
event Withdrawal(address indexed to, uint256 amount);
event extended_time(uint256 unlockTime);
```
Shows how to define and emit events for logging important actions such as deposits, withdrawals, and changes to the unlock time.

## Functions
The contract implements several functions that showcase different Solidity concepts:

- `constructor`: Initializes the contract by setting the owner and the unlock time.
- `receive`: A special function that allows the contract to receive Ether and calls the deposit function.
- `deposit`: Handles the deposit of funds, ensuring that the deposit amount is greater than 0 and emitting a Deposit event.
- `withdraw`: Allows the owner to withdraw funds after the unlock time has passed, ensuring the owner is the caller, the unlock time has elapsed, and there are funds to withdraw.
- `extendLockTime`: Enables the owner to extend the unlock time, ensuring the new time is later than the current unlock time.
- `getBalance`: A view function that returns the current balance of the wallet.
- `getRemainingLockTime`: A view function that returns the remaining time until the funds can be withdrawn.

## Deployment and Interaction
To deploy this contract:

- Compile the contract using a Solidity compiler (version 0.8.0 or higher).
- Deploy to your chosen Ethereum network (recommended Sepolia testnet).
- The address that deploys the contract automatically becomes the owner.
- Set an appropriate unlockTime (must be in the future) during deployment.


After deployment, interact with the contract by:

- Calling `deposit` or sending Ether directly to the contract to lock funds.
- Using `withdraw` after the unlock time to withdraw funds (only available to the owner).
- Extending the lock time with `extendLockTime`.
- Checking the wallet's balance with `getBalance`.
- Verifying the remaining lock time with `getRemainingLockTime`.

## Security Considerations
While this contract provides basic time-locked wallet functionality, consider the following:

- This contract is a learning project and has not been audited for production use.
- Ensure that the unlock time is set properly; once set, it cannot be shortened.
- The owner is the only address that can withdraw funds; ensure proper key management.


## Future Improvements
Potential enhancements to explore:

-Implement multi-sig functionality to require multiple approvals for withdrawals.
-Add the ability to set a withdrawal schedule or recurring withdrawals.
-Improve security by adding emergency withdrawal functionality with a timelock.
-Explore integration with decentralized identity solutions to enhance access control.
