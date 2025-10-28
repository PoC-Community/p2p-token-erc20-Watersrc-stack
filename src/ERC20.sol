// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interface/IERC20.sol";

contract ERC20 is IERC20 {
    string public name = "kotter";
    string public symbol = "KTTR";
    uint8 public decimals = 5;

    uint64 private _totalSupply;
    mapping(address owner => uint64) private _balances;
    mapping(address owner => mapping(address spender => uint64)) private _allowances;

    constructor (uint64 totalSupply_) {
        _totalSupply = totalSupply_;
    }

}
