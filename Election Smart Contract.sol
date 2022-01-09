// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Election{


    //Model a candidate
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    //Store account that we have voted
    mapping (address => bool) public votedornot;

    //Store Candidates
    //Fetch Candidates
    mapping(uint => Candidate) public candidates;

    

    //Sore candidate count
    uint public candidatesCount;

    //voted event
    event electionupdates ( 
        uint indexed _candidateId);

    constructor(){
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    //add candidates
    function addCandidate(string memory name) private{
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount,name,0);
    }
    
    function Vote(uint _candidateId)public{
        //the person has not voted again
        require(!votedornot[msg.sender], 'you have voted');

        //require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        //increase vote the person whom the
        candidates[_candidateId].voteCount ++;

        //rocord that voter has voted
        votedornot[msg.sender] = true;

        //trigger voted event
        emit electionupdates(_candidateId);
    }
}