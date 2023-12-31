//SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
//import "@openzeppelin/contracts/utils/Counters.sol";
contract BasicNFTMarketplace is ERC721URIStorage {

    //using Counters for Counters.Counter;
    uint256 private _tokenIDs = 0;
 
    constructor() ERC721("Basic NFT", "BNFT") {}

    function createNFT(string calldata tokenURI) public returns(uint256) {
        //_tokenIDs.increment();
        //uint256 currentID = _tokenIDs.current();
        _tokenIDs++;
        _safeMint(msg.sender, _tokenIDs);
        _setTokenURI(_tokenIDs, tokenURI);
        return _tokenIDs;
    }
}