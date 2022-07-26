// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC721 {
    
    // Event
    event Tranfer(address indexed _from, address indexed _to, uint indexed _tokenId );
    event Approval(address indexed _from, address indexed _approved, uint indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    // Function
    // Owner가 가지고있는 총 NFT 갯수
    function balanceOf(address _owner) external view returns(uint); 
    // _tokenId -> 소유하고있는 address
    function ownerOf(uint _tokenId) external view returns(address);

    // transfer
    function transferFrom(address _from, address _to, uint _tokenId) external;

    // approve 대리인 : 토큰하나에 대해서 
    function approve(address _to, uint _tokenId) external;
    // approve 대리인의 주소를 리턴해주는 함수.
    function getApprvoed(uint _tokenId) external view returns(address);

    // setApprovalForAll : owner 가진 모든토큰을 대리인 지정
    function setApprovalForAll(address _operator, bool _approved) external;
    // _approved 를 return 해주는 함수.
    function isApprovedForAll(address _owner, address _operator) external view returns(bool);
}