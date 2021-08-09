pragma solidity ^0.8.4;

contract Factory {
    bool public isActive = true;
    address admin;
    
    constructor() public {
        admin = msg.sender;
    }
    
    function toggleCircuitBreaker() external {
        require(admin == msg.sender);
        isActive = !isActive;
    }
}