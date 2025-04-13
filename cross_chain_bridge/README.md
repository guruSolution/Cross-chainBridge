# Stacks Cross-Chain Bridge

A decentralized bridge between Stacks and other blockchains for secure asset transfers, built with Clarity and tested with Vitest.

## Overview

This project implements a cross-chain bridge that enables the transfer of assets (STX, SIP-010 tokens, and NFTs) between the Stacks blockchain and other blockchains. The bridge uses a lock-and-mint mechanism secured by multi-signature authorization to ensure safe and verifiable cross-chain transactions.

## Features

- **Token Bridging**: Lock STX tokens on Stacks and mint equivalent tokens on target chains
- **NFT Bridging**: Transfer NFTs between Stacks and other blockchain ecosystems
- **Liquidity Pools**: Fast transfers using liquidity pools with customizable fee structures
- **Multi-signature Security**: Operations require approval from multiple authorized signers 
- **Rate Limiting**: Configurable daily limits to protect against mass withdrawals
- **Secure Operations**: Emergency pause functionality and other security controls

## Architecture

### Smart Contracts

The main components of the bridge include:

- **Asset Locking**: Securely lock assets on the source chain until they're released
- **Bridge Requests Tracking**: Monitor and manage cross-chain transfer requests
- **Multi-signature Authorization**: Ensure multiple validators approve operations
- **Liquidity Pool Management**: Enable fast transfers through liquidity provision

### Contract Structure

```
┌─────────────────────┐     ┌─────────────────┐     ┌─────────────────────┐
│                     │     │                 │     │                     │
│  Stacks Contracts   │◄────┤  Bridge Relay   ├────►│  Target Blockchain  │
│                     │     │                 │     │                     │
└─────────────────────┘     └─────────────────┘     └─────────────────────┘
         ▲                          ▲                          ▲
         │                          │                          │
         │                          │                          │
         │                          │                          │
         └──────────────────────────┴──────────────────────────┘
                                    │
                           ┌────────┴───────┐
                           │                │
                           │  Validators    │
                           │                │
                           └────────────────┘
```

## Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity development environment
- [Node.js](https://nodejs.org/) (v16 or higher)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/stacks-cross-chain-bridge.git
cd stacks-cross-chain-bridge
```

2. Install dependencies
```bash
npm install
# or
yarn install
```

3. Initialize Clarinet project (if not already done)
```bash
clarinet new stacks-bridge
```

### Development Setup

1. Set up a local Stacks chain for development
```bash
clarinet integrate
```

2. Deploy the contract to the local chain
```bash
clarinet deploy
```

## Testing

This project uses Vitest for testing the Clarity smart contracts.

### Running Tests

```bash
npm test
# or
yarn test
```

### Writing Tests

Tests are located in the `tests` directory. See the existing tests for examples of how to test the bridge functionality:

- Basic bridge operations (lock/unlock tokens)
- Liquidity pool operations
- NFT bridging
- Multi-signature operations
- Rate limiting

## Contract Functions

### Core Bridge Functions

- `lock-tokens`: Lock STX tokens for bridging to another chain
- `lock-tokens-secure`: Enhanced version with rate limiting
- `provide-liquidity`: Add liquidity to enable fast transfers
- `bridge-nft`: Bridge NFTs to other chains

### Administrative Functions

- `set-admin`: Change the bridge administrator
- `manage-signer`: Add or remove authorized signers
- `toggle-bridge-operations`: Emergency pause/unpause

### Multi-signature Operations

- `propose-operation`: Propose a bridge operation
- `approve-operation`: Approve a pending operation
- `execute-operation`: Execute an operation after sufficient approvals

### Read-only Functions

- `get-locked-balance`: Get a user's locked token balance

## Security Considerations

- The bridge uses multi-signature authorization to prevent single points of failure
- Rate limits protect against mass withdrawals
- Emergency pause functionality for responding to security incidents
- Carefully structured validation to prevent replay attacks

## Deployment

### Testnet Deployment

1. Configure your network settings in `Clarinet.toml`
2. Deploy to the testnet
```bash
clarinet publish --testnet
```

### Mainnet Considerations

Before deploying to mainnet:
- Complete comprehensive security audits
- Set up a decentralized validator network
- Implement proper monitoring and alerting systems
- Conduct extensive testnet trials

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

- [Stacks Foundation](https://stacks.org/)
- [Clarity Language Documentation](https://docs.stacks.co/docs/clarity/)
- [Clarinet Testing Framework](https://github.com/hirosystems/clarinet)