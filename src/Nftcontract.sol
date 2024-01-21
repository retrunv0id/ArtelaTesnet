// SPDX-License-Identifier: UNLICENSED
/*
  
LINKED : https://return-void.4everland.app/

Yt : https://www.youtube.com/channel/UCrh_gN8N-It0dAZyeO6MlFQ

Twitter : https://twitter.com/retrunvoid

Medium : https://medium.com/@retrunvoid

Github : https://github.com/retrunv0id

This contract was created for testnet purposes. There are no other elements in this contract

by retrunvoid

*/

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTretrunvoid is ERC721Enumerable, Ownable(msg.sender) {
    using Strings for uint256;

    uint256 private constant DEFAULT_MAX_SUPPLY = 5000;
    uint256 private constant DEFAULT_MINTING_FEE = 0.0006 ether;

    uint256 private maxSupply;
    uint256 private mintingFee;
    string private ipfsReference;

    mapping(address => bool) private _hasMinted;

    constructor(string memory _ipfsReference) ERC721("NFTretrunvoid", "NFTRV") {
        ipfsReference = _ipfsReference;
        maxSupply = DEFAULT_MAX_SUPPLY;
        mintingFee = DEFAULT_MINTING_FEE;
    }

  string private customBaseURI;

  function setBaseURI(string memory customBaseURI_) external onlyOwner {
    customBaseURI = customBaseURI_;
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return customBaseURI;
  }

  function tokenURI(uint256 tokenId) public view override
    returns (string memory)
  {
    return string(abi.encodePacked(super.tokenURI(tokenId), ".token.json"));
  }

    function setMaxSupply(uint256 newMaxSupply) external onlyOwner {
        maxSupply = newMaxSupply;
    }

    function setMintingFee(uint256 newFee) external onlyOwner {
        mintingFee = newFee;
    }

    function setIpfsReference(string memory newIpfsReference) external onlyOwner {
        ipfsReference = newIpfsReference;
    }

    function mint() external payable {
        require(!_hasMinted[msg.sender], "You have already minted an NFT");
        require(totalSupply() < maxSupply, "Max supply reached");
        require(msg.value >= mintingFee, "Insufficient payment");

        _hasMinted[msg.sender] = true;

        uint256 tokenId = totalSupply() + 1;
        _safeMint(msg.sender, tokenId);

        
        require(ownerOf(tokenId) == msg.sender, "Failed to mint NFT");

        address payable ownerWallet = payable(owner());
        ownerWallet.transfer(msg.value);
    }

    function hasMinted(address wallet) external view returns (bool) {
        return _hasMinted[wallet];
    }
}
