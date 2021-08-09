pragma solidity ^0.8.4;

import "./Child.sol";
import "@nomiclabs/buildler/console.sol";

contract ChildFactory {
    Child[] public children;
    
    event ChildCreated(uint date, uint256 data, address childAddress);
    
    event ChildLog(Child data);
    
    function createChild(uint256 _data) external{
        Child child = new Child(_data);
        children.push(child);
        emit ChildCreated(block.timestamp, _data, address(child));
        
    }
    
    function logChildren() external{
        
        for(uint i=0; i < children.length; i++){
            Child child = children[i];
            emit ChildLog(child);
        }
    }
    
}