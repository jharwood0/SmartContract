pragma solidity ^0.4.17;

contract Documents {
  mapping (address => Person) public people;
  address[] public addressLUT;

  struct Person {
    address owner; //proof of ownership
    mapping (bytes32 => bool) documents; //proof of existence map
    bytes32[] hashesLUT;
  }

  function addDocument(string document) {
    bytes32 proof = sha256(document);
    if(people[msg.sender].owner == 0){
      Person memory newPerson;
      newPerson.owner = msg.sender;
      people[msg.sender] = newPerson;
      addressLUT.push(msg.sender);
    }
    people[msg.sender].documents[proof] = true;
    people[msg.sender].hashesLUT.push(proof);
  }

  function checkDocument(string document) constant returns (bool){
    return people[msg.sender].documents[sha256(document)];
  }

  function getPeople() constant returns(address[]){
    address[] memory addresses = new address[](addressLUT.length);
    for(uint i = 0; i < addressLUT.length; i++){
      addresses[i] = addressLUT[i];
    }
    return addresses;
  }

}
