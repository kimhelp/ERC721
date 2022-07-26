// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ERC721.sol";

contract ERC721Enumerable is ERC721{
    uint[] private _allTokens;

    constructor(string memory _name, string memory _symbol) ERC721(_name,_symbol){}
    function mint(address _to) public {
        _mint(_to, _allTokens.length);
        // _allTokens.push(_allTokens.length);
    }
    function _afterToken(address _from,address _to,uint _token) internal override{
        _allTokens.push(_allTokens.length);
    }
}
/* tokenId 자동생성을 위한 totalSupply() 내 NFT 목록을 볼 수 있는 기능 */