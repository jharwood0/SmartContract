pragma solidity ^0.4.4;

contract Adoption {
  address[16] public adopters;

  function getAdopters() public returns(address[16]){
    return adopters;
  }
}
