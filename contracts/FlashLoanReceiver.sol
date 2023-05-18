// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./FlashLoan.sol";

contract FlashLoanReceiver {
    FlashLoan private pool;
    address private owner;

    event LoanReceived(address token, uint amount);

    constructor(address _poolAddress) {
        pool = FlashLoan(_poolAddress);
        owner = msg.sender;
    }

    function receiveTokens(address _tokenAddress, uint _amount) external {
        require(
            msg.sender == address(pool),
            "Only pool allowed to call the method"
        );
        require(
            ERC20(_tokenAddress).balanceOf(address(this)) == _amount,
            "Failed to take a loan"
        );
        emit LoanReceived(_tokenAddress, _amount);
        /**
         * Some logic what to do with a loan goes here
         */
        require(
            ERC20(_tokenAddress).transfer(msg.sender, _amount),
            "Transfer of tokens failed"
        );
    }

    function executeFlashLoan(uint _amount) external {
        require(msg.sender == owner, "Only Owner allowed to use this function");
        pool.flashLoan(_amount);
    }
}
