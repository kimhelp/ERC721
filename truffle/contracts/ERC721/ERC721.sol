// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./IERC721.sol";
import "./IERC721Metadata.sol";


// public   : 
// private  :
// external : 본인컨트렉트 서로 공유가안됨 외부끼리만됨. 
// internal : 본인컨트렉트 에서만됨 즉 외부는안됨. 


contract ERC721 is IERC721, IERC721Metadata{

    string public override name;
    string public override symbol;

    mapping(address => uint) private _balances;
    mapping(uint => address) private _owners;
    mapping(uint => address) private _tokenApprovals;
    mapping(address=> mapping(address=> bool)) private _operatorApprovals;

    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
    }

//owner가 갖고있는 총nft갯수
    function balanceOf(address _owner) external override view returns(uint) {
        require(_owner != address(0), "ERC721 : balance query for the zero address");
        return _balances[_owner];
    }
//_tokenId > 소유하고있는 address
    function ownerOf(uint _tokenId) public override view returns(address) {
        address owner = _owners[_tokenId];
        require(owner != address(0), "ERC721 : owner query for nonexistent token.");
        return owner;
    }
//approve 대리인 : 토큰하나에 대해서
    function approve(address _to, uint _tokenId) external override {
        address owner = ownerOf(_tokenId); //view 
        require(_to != owner, "ERC 721 : approval to current owner");
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender));
        
        _tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
        
    }

    //approve 대리인의 주소를 리턴해주는 함수
    function getApprvoed(uint _tokenId) public override view returns(address) {
        // tokenId가 실제 소유자가 있는가. 
        require(ownerOf(_tokenId) != address(0), "ERC721 : ");
        return _tokenApprovals[_tokenId];
    }

//setApprovalForAll : owner 가진 모든토큰을 대리인 지정
    // msg.sender , _operator 모든 tokenId 사용을 허락하겠다. true , false 
    function setApprovalForAll(address _operator, bool _approved) external override {
        require(msg.sender != _operator);
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    // 내가 msg.sender 동훈  _operator => true , false
    function isApprovedForAll(address _owner, address _operator) public override view returns(bool) {
        return _operatorApprovals[_owner][_operator];
    }


    function _isApprovedOrOwner(address _spender, uint _tokenId) private view returns(bool)  {
        address owner = ownerOf(_tokenId);
        require(owner != address(0));
        return (_spender == owner || isApprovedForAll(owner, _spender) ||  getApprvoed(_tokenId) == _spender);
    }

    // from A , 대리인 2가지 본인, 대리인,
    function transferFrom(address _from, address _to, uint _tokenId) external override {
        require(_isApprovedOrOwner(_from, _tokenId));
        require(_from != _to);

        _balances[_from] -= 1;
        _balances[_to] += 1;
        _owners[_tokenId] = _to;

        emit Tranfer(_from, _to, _tokenId);
    }

    function tokenURI(uint256 _tokenId) external override virtual view returns (string memory) {}

    // mint 
    // 10개 1~10
    // 10
    //mint
    function _mint(address _to, uint _tokenId) public {
        require(_to != address(0));
        address owner = ownerOf(_tokenId);
        require(owner == address(0));

        _afterToken(address(0), _to, _tokenId);
        _balances[_to] += 1;
        _owners[_tokenId] = _to;

        emit Tranfer(address(0), _to, _tokenId);
    }

    function _afterToken(address _from, address _to, uint _token)internal virtual {}
}
