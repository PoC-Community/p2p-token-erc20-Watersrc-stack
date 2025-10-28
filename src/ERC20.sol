// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interface/IERC20.sol";

contract ERC20 is IERC20 {
    string public name = "kotter";
    string public symbol = "KTTR";
    uint8 public decimals = 18;

    uint256 private _totalSupply;
    mapping(address owner => uint256) private _balances;
    mapping(address owner => mapping(address spender => uint64))
    private _allowances;

    constructor(uint256 initialSupply_) {
        _totalSupply = initialSupply_ * 10 ** uint256(decimals);
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }


    function _transfer(address from, address to, uint256 value) private returns (bool){
        if (from == address(0))
            revert("Invalid source addr");
        if (to == address(0))
            revert("Invalid destination addr");
        if (_balances[from] < value)
            revert("Not enough balance");

        _balances[from] -= value;
        _balances[to] += value;

        emit Transfer(from, to, value);
        return true;
    }


    function transfer(address to, uint256 value) public override returns (bool) {
        return _transfer(msg.sender, to, value);
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) public override returns (bool) {
        _allowances[msg.sender][spender] = uint64(value);

        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public override returns (bool) {
        if (_allowances[from][msg.sender] < value)
            revert("You are not allowed to move that much");
    
        _allowances[from][msg.sender] -= uint64(value);
        return _transfer(from, to, value);
    }

}
