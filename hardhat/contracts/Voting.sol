//SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Voting {
    // Create a structure template for each of the candidates
    struct Candidate {
        uint256 id;
        string name;
        uint256 numberOfVotes;
    }

    // List of all candidates
    Candidate[] public candidates;

    //mapp all candidtae
    mapping(string => bool) isCandidate;

    //owner's address
    address public owner;

    //Mapp all voters addresses
    mapping(address => bool) public voters;

    // List of voters
    address[] public listOfVoters;

    // Create a voting start and end session
    uint256 public votingStart;
    uint256 public votingEnd;

    //create an election status
    bool public electionStarted;

    // Restrict creating election to the owner only
    modifier onlyowner() {
        require(
            msg.sender == owner,
            "You are not allowed to create or to start the election"
        );
        _;
    }

    // check if election is ongoing
    modifier electionOngoing() {
        require(electionStarted, "No election Yet");
        _;
    }

    // Constructor :- runs only once while the contract is deploy [set the address of owner]
    constructor() {
        owner = msg.sender;
    }

    // function:- to start an election
    function startElection(
        string[] memory _candidates,
        uint256 _votingDuration
    ) public onlyowner {
        require(electionStarted == false, "Election is currently ongoing" );
        delete candidates;
        resetAllVotersStatus();

        for(uint256 i = 0; i < _candidates.length; i++){
            candidates.push(
                Candidate({
                    id: i,
                    name: _candidates[i],
                    numberOfVotes: 0
                })
            );
        }
        
        // setting election duration
        electionStarted = true;
        votingStart = block.timestamp;
        votingEnd = block.timestamp + (_votingDuration * 1 minutes);
    }

    // add new candidate
    function addCandidate(string memory _name) public  onlyowner electionOngoing{
        //check for period of election
        require(checkElectionPeriod(), "Election period has ended");

        // check for candidate registration
        if(isCandidate[_name]){
            revert("Already a candidate");
        }

        // add the candidate
        candidates.push(Candidate({
            id: candidates.length,
            name: _name,
            numberOfVotes: 0
        }));
    }

    // ckeck for voters status
    function votersStatus(address _voter)public view electionOngoing returns(bool){
        
        //condition check
        if(voters[_voter]){
            return true;
        }
        return false;
    }

    // to vote
    function voteTo(uint256 _id) public electionOngoing{
        //check for period of election
        require(checkElectionPeriod(), "Election period has ended");

        //check for the voters status
        require(!votersStatus(msg.sender), "You already Voted. You can only vote once.");

        //increasing the numberOfvotes of the selected id's candidate 
        candidates[_id].numberOfVotes++;

        //now after vote assign the user's status as voted by making it true
        voters[msg.sender] = true;

        // add this voter to the list
        listOfVoters.push(msg.sender);
    }

    //get the no. of votes
    function retriveVotes() public view returns(Candidate[] memory){
        return candidates;
    }

    // moniter the election time:- telling the remaining time of election
    function electionTimer() public view electionOngoing returns(uint256){
        if(block.timestamp >= votingEnd){
            return 0;
        }
        return(votingEnd - block.timestamp);
    }

    //check election period is going
    function checkElectionPeriod() public returns(bool){
        if(electionTimer() > 0){
            return true;
        }
        electionStarted = false;
        return false;
    }

    // reset the status of voters
    function resetAllVotersStatus() public onlyowner{
        for(uint i = 0; i < listOfVoters.length; i++){
            voters[listOfVoters[i]] = false;
        }
        delete listOfVoters;
    }
}
