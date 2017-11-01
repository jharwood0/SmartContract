pragma solidity ^0.4.17;

contract Documents {
  mapping (address => Person) public people;
  struct Person {
    address owner; //proof of ownership
    mapping (bytes32 => bool) documents; //proof of existence map
  }

  function notarize(string document) returns (bool) {
    bytes32 proof = sha256(document);
    if(people[msg.sender].owner == 0){
      Person memory newPerson;
      newPerson.owner = msg.sender;
      people[msg.sender] = newPerson;
    }
    people[msg.sender].documents[proof] = true;
    return true;
  }

  function check(string document) constant returns (bool){
    return people[msg.sender].documents[sha256(document)];
  }
}
