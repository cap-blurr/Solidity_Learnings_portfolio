// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// initialize contract
contract SimpleToken {
    // create state variables for our token
    string public name; // The token's name
    string public symbol; // The token's symbol
    uint8 public decimals; // 8 bit integer for storing the number of decimal places
    uint256 public totalSupply; // 256 bit integer storing the total number of tokens to be issued
    mapping(address => uint256) public balanceOf; // a mapping of addresses with their token balance
    mapping(address => mapping(address => uint256)) public allowance; /* a nested address list keeping track ...
                                                                    ... of how many tokens an address is allowed to spend on behalf of another address*/

    // called when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint256 value);

    // called when an address approves another address to spend tokens on their behalf
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // initialized at contract creation
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * 10**uint256(decimals); // allows for fractional ownership of the token
        balanceOf[msg.sender] = totalSupply; // assigning the total supply to the address that deploys the contract
    }

    // function to allow users to transfer the token to another address
    // takes in 2 parameters, the address to transfer to and the token amount
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;

        // first we check whether the user has enough tokens to transfer,
        // Then we deduct the amount of tokens from the address sending and add to the address receiving
        // we finally emit an event of a transfer happening and return true if the transfer is succesful
    }

    // a function that allows token holders to give approval to another address to spend their tokens
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
        // it takes 2 args,the address being approved and the amount they're allowed to spend
        // it updates the allowance mapping to record this permission
        // and then emits an approval event to announce this permission
        // finally returns true to indicate success
    }

    // The function below allows an approved address to transfer tokens on behalf of the token holder
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Insufficient allowance");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
        // the function takes 3 args, the address to transfer from,address to transfer to and the amount of tokens
        // it first checks if the _from address has enough tokens,then checks if msg.sender has been approved to spend atleast this much
        // If the first 2 checks pass,it subtracts the amount from the _from balance and adds it to the _to balance,it then reduces the allowance by the transfer amount
        // it then emits a transfer event and returns true if succesful
    }
}