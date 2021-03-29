pragma solidity ^0.7.0;

//contract to create FLUID with 15 million supply
contract FluidToken {
    //basic token properties
    string public constant  name = "Fluid Token";
    string public constant  symbol = "FLUID";
    uint8 public constant decimals = 18;
    uint256 public _totalSupply = 15000000000000000000000000; // 15M * 1e18
    address public _ownerAddress;
    

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

    //FLUID balance on addresses
    mapping(address => uint256) public balances;
    //amount allowed by msg.sender to _spender
    mapping(address => mapping(address => uint256)) public allowed;

    constructor() public {
        //assign all FLUID token to the issuer on contract execution
        balances[msg.sender] = _totalSupply;
        _ownerAddress = msg.sender;
    }

    //retrieves FLUID total supply
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    //retrieves primary owner of FLUID
    function ownerAddress() public view returns (address) {
        return _ownerAddress;
    }

    //retrieves FLUID balance on owners address
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    //transfer _value from msg.sender to  _transferTo
    function transfer(address _transferTo, uint256 _value) public returns (bool) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_transferTo] += _value;

        emit transferEvent(msg.sender, _transferTo, _value);
        return true;
    }

    //allow _spender to be able to use _value of FLUID from your account
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        
        emit approvalEvent(msg.sender, _spender, _value);
        return true;
    }

    //allow spender to transfer FLUID out from the grant account
    function transferFrom(address _transferFrom, address _transferTo, uint256 _value) public returns (bool){
        require(balances[_transferFrom] >= _value);
        require(allowed[_transferFrom][msg.sender] >= _value);
        balances[_transferFrom] -= _value;
        balances[_transferTo] += _value;
        allowed[_transferFrom][msg.sender] -= _value;

        emit transferEvent(_transferFrom, _transferTo, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
}