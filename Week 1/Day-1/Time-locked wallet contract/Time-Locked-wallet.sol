// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLockedWallet {
    // first declare our state variables
    address public owner;
    uint256 public unlockTime;
    uint256 public depositAmount;

    // the following events announce and log when someone deposits or withdraws funds and/or changes the unlocktime...
    //  ...taking into account details such as the amount and unlock time
    event Deposit(address indexed depositor, uint256 amount, uint256 unlockTime);
    event Withdrawal(address indexed to, uint256 amount);
    event extended_time(uint256 unlockTime);

    // the constructor initializes at contract deployment and sets the owner's address and the unlock time
    constructor(address _owner, uint256 _unlockTime) {
        require(_unlockTime > block.timestamp, "Unlock time must be in the future");
        owner = _owner;
        unlockTime = _unlockTime;
    }

    // this contract allows the contract to receive funds using the 'payable' keyword and just calls the deposit function
    receive() external payable {
        deposit();
    }

    // This function allows users to deposit funds into the wallet using the 'payable' keyword
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        depositAmount += msg.value;
        emit Deposit(msg.sender, msg.value, unlockTime);

        // it first checks to make sure that the deposit amount is greater than 0,
        // then proceeds to set the deposit amount to the amount sent if it is greater than 0
        // it finally emits an event with details of the deposit
    }

    // the withdraw function allows users to withdraw funds after the unlock time has elapsed
    function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(block.timestamp >= unlockTime, "Funds are still locked");
        require(depositAmount > 0, "No funds to withdraw");

        uint256 amount = depositAmount;
        depositAmount = 0;

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawal(owner, amount);

        //it first checks to make sure that the person calling the function is the owner,and that the unlock time has...
        // ... elapsed and that the there are actually funds to withdraw

        // if so it sets the users deposit back to 0,then sends the owner's funds using 'call' and checks to see if transfer was succesful
        // it finally emits a withdrawal event with the owner address and the amount withdrawn
    }

    // this function allows users to extend their locktime
    function extendLockTime(uint256 _newUnlockTime) public {
        require(msg.sender == owner, "Only the owner can extend the lock time");
        require(_newUnlockTime > unlockTime, "New unlock time must be later than current unlock time");
        unlockTime = _newUnlockTime;

        emit extended_time(unlockTime);

        // it first checks to make sure that the caller is the owner and that the new unlock time is greater than the current one
        // it proceeds to set the unlock time to the new unlock time value

        // it emits an extended time event announcing the new unlock time
    }

    // the function is called to check for the user's balance
    function getBalance() public view returns (uint256) {
        return depositAmount;
        
        // it simply returns the depositAmount
    }

    // the function returns the remaining unlock time
    function getRemainingLockTime() public view returns (uint256) {
        if (block.timestamp >= unlockTime) {
            return 0;
        }
        return unlockTime - block.timestamp;

        // it first checks to make sure that the unlock time is not greater than the current time and if it is, it returns 0
        // if not it returns the time left until unlock
    }
}