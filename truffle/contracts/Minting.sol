// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.10;

// import "openzeppelin-solidity/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// contract Minting is ERC721{
//     constructor(string memory _name, string memory _symbol)ERC721(_name,_symbol){

//     }
//     function _minting(uint _tokenID) public{
//         _mint(msg.sender,_tokenID);
//     }

//     function tokenURI(uint _tokenID) public override pure returns(string memory){
//         return "http://localhost:3000/metadata/1/1.json";
//     }
// }