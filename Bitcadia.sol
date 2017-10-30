pragma solidity ^0.4.6; //We have to specify what version of compiler this code will use

contract Bitcadia {
    
    struct Claim {
        bytes32 id;
        address authoredBy;
        uint date;
        string title;
        string content;
        uint value;
    }
    
    struct Challenge {
        bytes32 id;
        uint date;
        bytes32 claimId;
        address challengedBy;
        string reason;
    }
    
    struct Dispute {
        bytes32 id;
        uint date;
        bytes32 challengeId;
        address judgedBy;
        bool isTrue;
    }
    
    mapping(bytes32 => Claim) claims;
    mapping(bytes32 => Challenge) challenges;
    mapping(bytes32 => Dispute) disputes;
    
    bytes32[] claimIds;
    bytes32[] challengeIds;
    bytes32[] disputeIds;
    
    function Bitcadia() public {
        
    }
    
    //event NewClaim(bytes32 id, uint date, address authoredBy, string title, string content, uint value);

    function newClaim(string _title, string _content, uint _value, uint _date) public returns (bool success) {
        bytes32 id = keccak256(_date, msg.sender, now);
        
        Claim memory claim = Claim({
            id: id,
            date: _date,
            authoredBy: msg.sender,
            title: _title,
            content: _content,
            value: _value //msg.value
        });
        
        claimIds.push(id);
        claims[id] = claim;
        
        //NewClaim(id, now, msg.sender, _title, _content, _value);
        
        return true;
    }
    
    //event NewChallenge(bytes32 id, uint date, bytes32 claimId, address challengedBy, string reason);
    
    function challengeClaim(bytes32 _claimId, string _reason) public returns (bool success) {
        bytes32 id = keccak256(msg.sender, now, _reason);
        
        Challenge memory challenge = Challenge({
            id: id,
            date: now,
            claimId: _claimId,
            challengedBy: msg.sender,
            reason: _reason
        });
        
        challengeIds.push(id);
        challenges[id] = challenge;
        
        //NewChallenge(id, now, _claimId, msg.sender, _reason);
        
        return true;
    }
    
    //event NewDispute(bytes32 id, uint date, bytes32 challengeId, address judgedBy, bool isTrue);
    
    function disputeClaim(bytes32 _challengeId, bool _isTrue) public returns (bool) {
        bytes32 id = keccak256(msg.sender, now, _challengeId, _isTrue);
        
        Dispute memory dispute = Dispute({
            id: id,
            date: now,
            challengeId: _challengeId,
            judgedBy: msg.sender,
            isTrue: _isTrue
        });
        
        disputeIds.push(id);
        disputes[id] = dispute;
        
        //NewDispute(id, now, _challengeId, msg.sender, _reason);
        
        return true;
    }
    
    function getClaims() public returns (bytes32[]) {
        return claimIds;
    }
    
    function getClaimDetails(bytes32 _claimId) public returns (Claim) {
        return claims[_claimId];
    }
}