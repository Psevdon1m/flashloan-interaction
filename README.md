# FlashLoan Smart Contract

This is a Solidity smart contract that implements a flash loan mechanism. It allows users to borrow tokens from a pool of funds temporarily, as long as the borrowed tokens are returned within the same transaction. The contract includes the ERC20 token contract, a flash loan contract, and a flash loan receiver contract.

## ERC20 Contract

The ERC20 contract is a standard implementation of the ERC20 token. It includes functionalities such as transferring tokens, approving token transfers, and checking token balances.

## FlashLoan Contract

The FlashLoan contract serves as the main contract that manages the flash loan functionality. It includes the following features:

### State Variables

- `token`: An instance of the ERC20 contract representing the token to be used for the flash loan.
- `poolBalance`: The balance of the token held in the flash loan pool.

### Constructor

- `constructor`: Initializes the flash loan contract by providing the address of the ERC20 token contract.

### External Functions

- `depositTokens`: Allows users to deposit tokens into the flash loan pool.
- `flashLoan`: Allows users to borrow tokens from the flash loan pool and execute a custom logic in the receiver contract.

## FlashLoanReceiver Contract

The FlashLoanReceiver contract serves as the receiver contract for the flash loan. It receives the borrowed tokens and executes custom logic. It includes the following features:

### State Variables

- `pool`: An instance of the FlashLoan contract representing the flash loan pool.
- `owner`: The address of the contract owner.

### Events

- `LoanReceived`: Triggered when tokens are received from the flash loan pool.

### Constructor

- `constructor`: Initializes the flash loan receiver contract by providing the address of the flash loan contract.

### External Functions

- `receiveTokens`: Receives the borrowed tokens from the flash loan pool and emits a `LoanReceived` event.
- `executeFlashLoan`: Allows the contract owner to execute a flash loan by calling the `flashLoan` function in the flash loan pool contract.

## Usage

1. Deploy the ERC20 contract to the Ethereum network.
2. Deploy the FlashLoan contract, providing the address of the ERC20 token contract.
3. Users can deposit tokens into the flash loan pool by calling the `depositTokens` function in the FlashLoan contract.
4. Users can borrow tokens from the flash loan pool and execute custom logic by creating a receiver contract and calling the `flashLoan` function in the FlashLoan contract.
5. The receiver contract should implement the `receiveTokens` function to receive the borrowed tokens and handle the custom logic.
6. The receiver contract can also call the `executeFlashLoan` function in the FlashLoanReceiver contract to execute a flash loan if the caller is the owner of the receiver contract.

Note: It is important to test and verify the contracts' functionality and security before deploying them to a production environment.

**Disclaimer: This readme file is for informational purposes only and does not constitute legal or financial advice. Use the provided smart contracts at your own risk.**
