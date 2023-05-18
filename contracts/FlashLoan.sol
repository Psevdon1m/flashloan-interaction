// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./ERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

interface IReceiver {
    function receiveTokens(address tokenAddress, uint amount) external;
}

contract FlashLoan is ReentrancyGuard {
    ERC20 public token;
    uint public poolBalance;

    constructor(address _tokenAddress) {
        token = ERC20(_tokenAddress);
    }

    function depositTokens(uint256 _amount) external nonReentrant {
        require(_amount >= 0, "Deposit amount more than zero");
        token.transferFrom(msg.sender, address(this), _amount);
        poolBalance += _amount;
    }

    function flashLoan(uint _borrowAmount) external nonReentrant {
        require(_borrowAmount > 0, "Must be more than 0");

        uint balanceBeforeLoan = token.balanceOf(address(this));
        require(balanceBeforeLoan >= _borrowAmount, "Insuff amount in pool");

        assert(poolBalance == balanceBeforeLoan);

        token.transfer(msg.sender, _borrowAmount);

        IReceiver(msg.sender).receiveTokens(address(token), _borrowAmount);

        uint balanceAfterLoan = token.balanceOf(address(this));
        require(balanceAfterLoan >= balanceBeforeLoan, "Loan was not returned");
    }
}
