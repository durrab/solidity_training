pragma solidity ^0.8.4;

contract Child {
    uint256 public data;
    
    constructor(uint _data) {
        data = _data;
    }
}