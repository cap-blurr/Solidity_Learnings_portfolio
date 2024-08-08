// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicVotingSystem {
    // setting basic structs 
    struct Proposal {
        string description;
        uint256 voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint256 votedProposalId;
    }

    // declaring state variables
    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    // events to notify when a new proposal is added and when a vote is cast for a specific proposal
    event ProposalAdded(uint256 proposalId, string description);
    event Voted(address voter, uint256 proposalId);

    // modifier to be added to functions that restricts certain functions to only be called by the chairperson (owner) of the contract
    modifier onlyChairperson() {
        require(msg.sender == chairperson, "Only chairperson can perform this action");
        _;
    }

    // constructor to set the chairperson as the person who deploys the contract
    constructor() {
        chairperson = msg.sender;
    }

    // a function to add a proposal with the 'onlychairperson' modifier used
    function addProposal(string memory _description) public onlyChairperson {
        proposals.push(Proposal({
            description: _description,
            voteCount: 0
        }));
        emit ProposalAdded(proposals.length - 1, _description);

        // the function adds a new proposal struct to the proposals array with the description and vote count set to 0
        // emits a Proposal added event with the new proposal ID and description
    }

    // a function to allow a user to vote
    function vote(uint256 _proposalId) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.hasVoted, "You have already voted.");
        require(_proposalId < proposals.length, "Invalid proposal ID.");

        sender.hasVoted = true;
        sender.votedProposalId = _proposalId;

        proposals[_proposalId].voteCount += 1;

        emit Voted(msg.sender, _proposalId);

        // it first retrieves the voters info from the voters mapping
        // checks to see that the voter hasnt voted before and the proposal ID is valid
        // marks the voter as having voted and increments the votecount for the chosen proposal
        // emits a voted event to announce the vote


    }

    // function to return the total number of proposals
    function getProposalCount() public view returns (uint256) {
        return proposals.length;

        // basically returns the length of the proposals array
    }

    // function to recieve the details of a specific proposal
    function getProposal(uint256 _proposalId) public view returns (string memory, uint256) {
        require(_proposalId < proposals.length, "Invalid proposal ID.");
        Proposal storage proposal = proposals[_proposalId];
        return (proposal.description, proposal.voteCount);

        // it first checks if the proposal ID is valid
        // then retrieves the proposal from the proposals array and returns the description and the vote count
    
    }
}