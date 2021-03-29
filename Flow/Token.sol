pragma solidity ^0.7.0;

import "../Fluid/Token.sol";

//contract to regulate Flow with maximum of 30 million supply
contract FlowToken {
    //basic token properties
    string public constant  name = "Flow Token";
    string public constant  symbol = "Flow";
    uint8 public constant decimals = 18;
    uint256 public _totalSupply; // 30M * 1e18  

    //transfer event between addresses i.e _transferFrom to _transferTo
    event transferEvent(
        address indexed _transferFrom,
        address indexed _transferTo,
        uint256 _value
    );

    //approval event from msg.sender 
    event approvalEvent(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    //Flow balance on addresses
    mapping(address => uint256) public balances;
    //amount allowed by msg.sender to _spender
    mapping(address => mapping(address => uint256)) public allowed;

    //retrieves Flow total supply
    function totalSupply(address fluidAddress) public view returns (uint256) {
        FluidToken _fluidToken = FluidToken(fluidAddress);
        uint256 fluidSupply = _fluidToken.totalSupply();
        address ownerAddress = _fluidToken.ownerAddress();
        uint256 remainingSupply = _fluidToken.balanceOf(ownerAddress);
        //rebase mechanism to distribute the supply
        return (fluidSupply - remainingSupply) * 2;
    }

    //retrieves Flow balance on owners address
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    //transfer _value from msg.sender to  _transferTo
    function transfer(address _transferTo, uint256 _value, address fluidAddress) public returns (bool) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        
        FluidToken _fluidToken = FluidToken(fluidAddress);
        address ownerAddress = _fluidToken.ownerAddress();
        uint256 ownerShare = _value/10; //ownerAddress get 10% of the transferred token
        balances[ownerAddress] += ownerShare;
        balances[_transferTo] += _value - ownerShare; //recipient gets 90% of the transferred token

        emit transferEvent(msg.sender, _transferTo, _value);
        emit transferEvent(msg.sender, ownerAddress, _value);
        return true;
    }

    //allow _spender to be able to use _value of Flow from your account
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        
        emit approvalEvent(msg.sender, _spender, _value);
        return true;
    }

    //allow spender to transfer Flow out from the grant account
    function transferFrom(address _transferFrom, address _transferTo, uint256 _value, address fluidAddress) public returns (bool){
        require(balances[_transferFrom] >= _value);
        require(allowed[_transferFrom][msg.sender] >= _value);
        balances[_transferFrom] -= _value;

        FluidToken _fluidToken = FluidToken(fluidAddress);
        address ownerAddress = _fluidToken.ownerAddress();
        uint256 ownerShare = _value/10; //ownerAddress get 10% of the transferred token
        balances[ownerAddress] += ownerShare;
        balances[_transferTo] += _value - ownerShare; //recipient gets 90% of the transferred token
        allowed[_transferFrom][msg.sender] -= _value; 

        emit transferEvent(_transferFrom, _transferTo, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
      return allowed[_owner][_spender];
    }
}