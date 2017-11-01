pragma solidity ^0.4.17;

contract Documents {
  mapping (address => Person) public people;
  struct Person {
    address owner; //proof of ownership
    mapping (bytes32 => bool) documents; //proof of existence map
  }

  function notarize(string document) returns (bool) {
    var proof = sha256(document);
    if(people[msg.sender].length == 0){
      Person memory newPerson;
      newPerson.owner = msg.sender;
      newPerson.documents[proof] = true;
      people[msg.sender] = newPerson;
    }else{
      people[msg.sender].documents[proof] = true;
    }
    return true;
  }

  function check(string document) returns (bool){
    return people[msg.sender].documents[sha256(document)];
  }
}
