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

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Retrunvoid is ERC20 {
    address private _owner;
    uint256 private constant _totalSupply = 5000000000000000000000000000000000;
    uint256 private constant _claimPercentage = 1;
    uint256 private constant _maxClaimAmount = (_totalSupply * _claimPercentage) / 100000;
    uint256 private _mintedSupply;
    uint256 private _claimFee = 6000000000000;
    bool private _claimAllowed = true;

    mapping(address => bool) private _claimed;

    constructor() ERC20("RetrunVoid", "RV") {
        _owner = msg.sender;
        _mintedSupply = 0;
        _mint(_owner, _totalSupply);
    }

    function claimTokens() external payable {
        require(!_claimed[msg.sender], "RetrunVoidToken: Already claimed");
        require(msg.value >= _claimFee, "RetrunVoidToken: Insufficient fee");
        require(_claimAllowed, "RetrunVoidToken: Claiming is not allowed anymore");

        uint256 tokensToClaim = calculateTokensToClaim();

        _claimed[msg.sender] = true;
        _transfer(_owner, msg.sender, tokensToClaim);
        _mintedSupply += tokensToClaim;

        address payable owner = payable(_owner);
        owner.transfer(msg.value);


        if ((_mintedSupply * 100) / _totalSupply >= 10) {
            _claimAllowed = false;
        }
    }

    function calculateTokensToClaim() private view returns (uint256) {
        uint256 remainingSupply = _totalSupply - _mintedSupply;
        uint256 tokensToClaim = remainingSupply < _maxClaimAmount ? remainingSupply : _maxClaimAmount;
        return tokensToClaim;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function mintedSupply() public view returns (uint256) {
        return _mintedSupply;
    }

    function claimed(address account) external view returns (bool) {
        return _claimed[account];
    }

    function setClaimFee(uint256 fee) external {
        require(msg.sender == _owner, "RetrunVoidToken: Only owner can set claim fee");
        _claimFee = fee;
    }

    function allowClaiming() external {
        require(msg.sender == _owner, "RetrunVoidToken: Only owner can allow claiming");
        _claimAllowed = true;
    }

    function exchangeTokens(uint256 tokenAmount) external {
        require(tokenAmount > 0, "RetrunVoidToken: Invalid token amount");
        require(balanceOf(msg.sender) >= tokenAmount, "RetrunVoidToken: Insufficient balance");

        uint256 liquidityAmount = tokenAmount * 2;
        _burn(msg.sender, tokenAmount);
        _mint(address(this), liquidityAmount);
    }

    function burnTokens(uint256 tokenAmount) external {
        require(msg.sender == _owner, "RetrunVoidToken: Only owner can burn tokens");
        require(tokenAmount > 0, "RetrunVoidToken: Invalid token amount");
        require(balanceOf(msg.sender) >= tokenAmount, "RetrunVoidToken: Insufficient balance");

        _burn(msg.sender, tokenAmount);
        _mintedSupply -= tokenAmount;
    }
}

 