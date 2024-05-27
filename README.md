# Voting System

This is a voting DApp which starts the election for the candidate and the voter can vote for their choice of candidate only once. New candidates can register only by the owner and the election also starts by only the owner. It is a basic election voting system.

## Features

- Only the owner can start the poll.
- Only the owner can add candidates.
- One voter, one vote.
- User-friendly interface.

## Installation Instructions

### Prerequisites

- Node.js
- Hardhat
- Web.js or Ether.js
- A code editor (e.g., Visual Studio Code)
- MetaMask wallet Chrome extension


1. **Clone the repository:**
    ```bash
    git clone https://github.com/OjasTulswani/Voting-DApp.git
    cd voting-system
    ```

2. **Install dependencies:**
    ```bash
    npm install
    ```

3. **Compile the smart contracts:**
    ```bash
    npx hardhat compile
    ```

4. **Deploy the smart contracts to the Amoy network:**
    Ensure you have configured the Amoy network settings in your Hardhat configuration file.
    ```bash
    npx hardhat ignition deploy ./ignition/modules/Voting.js --network amoy
    ```

5. **Run the frontend:**
    Open `index.html` in your web browser or use a live server extension in your code editor.

## Usage

1. **Connect MetaMask wallet:**
    - Open MetaMask and connect it to the Amoy network.
    - Ensure you have some test tokens to pay for transactions.

2. **Start the Election (Owner Only):**
    - The owner can start the election by interacting with the contract through the provided interface.

3. **Add Candidates (Owner Only):**
    - The owner can add new candidates to the election by providing their details through the interface.

4. **Vote:**
    - Connect your MetaMask wallet.
    - Select the ID of your favorite candidate and cast your vote.

## Technologies Used

- **Solidity**: For writing smart contracts.
- **Hardhat**: For development and deployment.
- **Ether.js**: For interacting with the Ethereum blockchain.
- **Node.js**: For package management and scripts.
- **HTML, CSS, JavaScript**: For the frontend.


## License

This project is licensed under the MIT License.

## Contact Information

For any questions or feedback, please contact:

- Email: ojastulswani@gmail.com
- GitHub: [OjasTulswani](https://github.com/OjasTulswani)
