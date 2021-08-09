pragma solidity ^0.8.4;


import "./Factory.sol";

contract Oracle {
    
    address admin;
    
    uint public rand;
    
    constructor() public  {
        admin = msg.sender;
    }
    
    function feedRandomness(uint _rand) external {
        require(msg.sender == admin);
        rand = _rand;
        
    }
    
}
contract MyContract {
    
    
    Oracle oracle;
    uint nonce;
    
     address admin;
    
    constructor(address oracleAddress) public  {
        admin = msg.sender; // this is where the admin address is saved when you deploy your smart contract
        oracle = Oracle(oracleAddress);
    }
    
    function randomeGenerate() external returns(uint) {
        uint rand = _randModulus(10);
        return rand;
    }
    
    function _randModulus(uint mod) internal returns(uint){
        
        uint rand =  uint(keccak256(abi.encodePacked(nonce,oracle.rand,block.timestamp,block.difficulty,msg.sender))) % mod;
        nonce++;
        return rand;
        
    }
    
    function length(string calldata str) external pure returns(uint) {
        return bytes(str).length;
    }
    
    function concatenate(string calldata a, string calldata b) external pure returns(string memory){
        return string(abi.encodePacked(a,b));
    }
    
    function reverse(string calldata _str) external pure returns(string memory){
        bytes memory str = bytes(_str);
        string memory tmp = new string(str.length);
        bytes memory _reverse = bytes(tmp);
        
        for(uint i = 0; i < str.length; i++){
            _reverse[str.length - i - 1] = str[i];
        }
        
        return string(_reverse);
    }
    
    function compare(string calldata a, string calldata b ) external pure returns(bool){
       return keccak256( abi.encodePacked(a)) ==  keccak256(abi.encodePacked(b));
    }
    
    // calculate fees
    function calculateFee(uint amount) external pure returns(uint){
        require((amount / 10000) * 10000 == amount, 'too small');
        return amount * 185 / 10000;
    }
    
    
    // Circuit Breaker
    function withDraw() external view contractIsActive() returns(uint) {
        return 100;
    }
    
    receive() external payable {
        
    }
    
    modifier contractIsActive() {
       require(Factory(admin).isActive() == true);
       _;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



