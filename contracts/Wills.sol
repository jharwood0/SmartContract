pragma solidity ^0.4.17;

contract Wills {
  mapping (address => Person) public people;
  struct Person {
    address _owner; //proof of ownership
    mapping (bytes32 => bool) documents; //proof of existence map
  }

  function notarize(string document) returns (bool) {
    var proof = sha256(document);
    people[msg.sender].documents[proof] = true;
    return true;
  }

  function check(string document) returns (bool){
    return people[msg.sender].documents[sha256(document)];
  }
}
