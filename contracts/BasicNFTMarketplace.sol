//SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

 struct NFTListing {
        uint256 price;
        address seller;
    }

contract BasicNFTMarketplace is ERC721URIStorage, Ownable(msg.sender) {

    //using Counters for Counters.Counter;
    uint256 private _tokenIDs = 0;
    mapping(uint256 => NFTListing) private _listing;
    event NFTTransfer(uint256 tokenID, address to, string tokenURI, uint256 price);

    constructor() ERC721("Basic NFT", "BNFT") {
        
    }

    function createNFT(string calldata tokenURI) public returns(uint256) {
        //_tokenIDs.increment();
        //uint256 currentID = _tokenIDs.current();
        _tokenIDs++;
        _safeMint(msg.sender, _tokenIDs);
        _setTokenURI(_tokenIDs, tokenURI);
        emit NFTTransfer(_tokenIDs, msg.sender, tokenURI, 0);
        return _tokenIDs;
    }

    function listNFT(uint256 tokenID, uint256 price) public {
        require(price > 0, "Price must be greater than zero to list NFT");
        transferFrom(msg.sender, address(this), tokenID);
        _listing[tokenID] = NFTListing(price, msg.sender);
        emit NFTTransfer(tokenID, address(this), "", price);
    }

    function buyNFT(uint256 tokenID) public payable {
        NFTListing memory listing = _listing[tokenID];
        require(listing.price > 0, "NFT not listed for sale");
        require(msg.value == listing.price, "incorrect price");
        transferFrom(address(this), msg.sender, tokenID);
        clearListing(tokenID);
        payable(msg.sender).transfer(listing.price * 95 / 100);
        emit NFTTransfer(tokenID, msg.sender, "", 0);
    }

    function cancelListing(uint256 tokenID) public {
        NFTListing memory listing = _listing[tokenID];
        require(listing.price > 0, "NFT not listed for sale");
        require(listing.seller == msg.sender, "you're not the owner");
        transferFrom(address(this), msg.sender, tokenID);
        clearListing(tokenID);
        emit NFTTransfer(tokenID, msg.sender, "", 0);
    }

    function withdrawFunds() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        payable(owner()).transfer(balance);
    }

    function clearListing(uint256 tokenID) public {
        _listing[tokenID].price = 0;
        _listing[tokenID].seller = address(0);
    }


}