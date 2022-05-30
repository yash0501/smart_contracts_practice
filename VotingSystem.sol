// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Ballot {

    // Variables
    struct vote {
        address voterAddress;
        bool choice;
    }

    struct voter {
        string voterName;
        string voterAadhaar;
        address voterAddress;
        bool voted;
    }

    uint private countResult = 0;
    uint public finalResult = 0;
    uint public totalVoters = 0;
    uint public totalVotes = 0;

    address public balltOfficialAddress;
    string public ballotOfficialName;
    string public proposal;

    mapping(address => voter) public voterRegistry;
    mapping(uint => vote) private votes;

    enum State { Created, Voting, Ended }
    State public state;

    // Modifiers
    modifier condition(bool _condition) {
        require(_condition);
        _;
    }

    modifier onlyOfficial() {
        require(msg.sender == balltOfficialAddress);
        _;
    }

    modifier inState(State _state) {
        require(state == _state);
        _;
    }
    // Events

    // Functions
    constructor(string memory _ballotOfficialName, string memory _proposal) {
        balltOfficialAddress = msg.sender;
        ballotOfficialName = _ballotOfficialName;
        proposal = _proposal;
        state = State.Created;
    }
    
    function addVoter(string memory _voterName, string memory _voterAadhaar, address _voterAddress) public inState(State.Created) onlyOfficial {
        voter memory v;
        v.voterName = _voterName;
        v.voterAadhaar = _voterAadhaar;
        v.voterAddress = _voterAddress;
        v.voted = false;
        voterRegistry[_voterAddress] = v;
        totalVoters++;
    }

    function startVote() public inState(State.Created) onlyOfficial {
        state = State.Voting;
    }

    function castVote(bool _choice) public inState(State.Voting) returns (bool voted){
        bool found = false;
        // check if voter exists in system
        if (bytes(voterRegistry[msg.sender].voterName).length!=0&&!voterRegistry[msg.sender].voted){
            voterRegistry[msg.sender].voted = true;
            vote memory v;
            v.voterAddress = msg.sender;
            v.choice = _choice;
            if(_choice){
                countResult++;
            }
            votes[totalVotes] = v;
            totalVotes++;
            found = true;
        }
        return found;
    }

    function endVote() public inState(State.Voting) onlyOfficial {
        state = State.Ended;
        finalResult = countResult;
    }
}
