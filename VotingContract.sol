// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingContract {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    mapping(string => Candidate) private candidates;

    event DonationReceived(address indexed sender, uint256 amount);

    constructor() {
        candidates["John"] = Candidate("John", 0);
        candidates["Paul"] = Candidate("Paul", 0);
    }

    function vote(string memory candidateName) public onlyValidCandidate(candidateName) {
        candidates[candidateName].voteCount++;
    }

    function getCandidateVoteCount(string memory candidateName) public view returns (Candidate memory) {
        return candidates[candidateName];
    }

    function donate() public payable {
        emit DonationReceived(msg.sender, msg.value);
    }

    modifier onlyValidCandidate(string memory candidateName) {
        require(
            keccak256(bytes(candidateName)) == keccak256(bytes("John")) ||
            keccak256(bytes(candidateName)) == keccak256(bytes("Paul")),
            "You are not allowed to vote"
        );
        _;
    }
}
