// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StarPoint {
    string public name = "StarPOINT";
    string public symbol = "STRP";
    uint256 public totalSupply;
	address public owner;
	
	struct Partner {
	    address partner;
	    bool isPartner;
	}
	
	struct Member {
	    address member;
	    bool isMember;
	}
	
	mapping (address => uint256) public balanceOf;
	mapping (address => mapping (address => uint256)) public allowance;
	mapping (address => Partner) public partners;
	mapping (address => Member) public members;
	
	event Approval(address indexed owner, address indexed spender, uint256 value);
	event Transfer(address indexed from, address indexed to, uint256 value);
	event Issue(uint256 amount, address partner);
	event Reward(address indexed partner, address indexed member, uint256 value);
	event Redeem(address indexed member, address indexed partner, uint256 value);
	event PartnerRedeem(address indexed member, address indexed partner, uint256 value);
	event RegisterPartner(address partner);
	event RegisterMember(address member);
	
	constructor() {
		owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "owner only");
        _;
    }
    
    modifier onlyPartner() {
        require(partners[msg.sender].isPartner, "partner only");
        _;
    }
    
    modifier onlyMember() {
        require(members[msg.sender].isMember, "member only");
        _;
    }
    
    function registerPartner(address _address) public onlyOwner {
        require(!partners[_address].isPartner, "already a partner");
        require(!members[_address].isMember, "member cant register as partner");
        partners[_address].partner = _address;
        partners[_address].isPartner = true;
        emit RegisterPartner(_address);
    }
    
    function registerMember(address _address) public onlyPartner {
        require(!members[_address].isMember, "already a member");
        require(!partners[_address].isPartner, "partner cant register as member");
        members[_address].member = _address;
        members[_address].isMember = true;
        emit RegisterMember(_address);
    }
    
    function issue(uint256 _amount, address _partner) public onlyOwner {
        require(totalSupply + _amount > totalSupply);
        require(balanceOf[_partner] + _amount > balanceOf[_partner]);
        require(partners[_partner].isPartner, "address is not a partner");
        
        balanceOf[_partner] += _amount;
        totalSupply += _amount;
        emit Issue(_amount,_partner);
    }
    
    function reward(address _member, uint256 _value) public onlyPartner {
        require(balanceOf[msg.sender] >= _value,"not enough balance");
        balanceOf[msg.sender] = balanceOf[msg.sender] - _value;
        balanceOf[_member] = balanceOf[_member] + _value;
        emit Reward(msg.sender, _member, _value);
    }
    
    function approve(address _spender, uint256 _value) public {
        require(_value != 0 && balanceOf[msg.sender] >= _value, "not enough balance");
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }
    
    function redeem(address _member, address _partner, uint256 _value) public onlyMember {
        require(balanceOf[_member] >= _value,"not enough balance");
        require(balanceOf[_partner] + _value > balanceOf[_partner],"balance overflow");
        balanceOf[_member] = balanceOf[_member] - _value;
        balanceOf[_partner] = balanceOf[_partner] + _value;
        emit Redeem(_member, _partner, _value);
    }
    
    function partnerRedeem(address _member, address _partner, uint256 _value) public onlyPartner {
        require(balanceOf[_member] >= _value,"not enough balance");
        require(balanceOf[_partner] + _value > balanceOf[_partner],"balance overflow");
        require(allowance[_member][msg.sender] >= _value ,"not enough allowance");
        balanceOf[_member] = balanceOf[_member] - _value;
        balanceOf[_partner] = balanceOf[_partner] + _value;
        allowance[_member][msg.sender] = allowance[_member][msg.sender] - _value;
        emit PartnerRedeem(_member, _partner, _value);
    }
    
    function transfer(address _from, address _to, uint256 _value) public onlyMember {
        require(members[_to].isMember,"can transfer to member only");
        require(balanceOf[_from] >= _value,"not enough balance");
        require(balanceOf[_to] + _value > balanceOf[_to],"balance overflow");
        balanceOf[_from] = balanceOf[_from] - _value;
        balanceOf[_to] = balanceOf[_to] + _value;
        emit Transfer(_from, _to, _value);
    }
    
    
}