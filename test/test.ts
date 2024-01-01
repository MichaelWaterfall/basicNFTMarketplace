import { ethers } from "hardhat";
import { expect } from "chai";
import { token } from "../typechain-types/@openzeppelin/contracts";
import { Contract } from "hardhat/internal/hardhat-network/stack-traces/model";

describe("DeployBasicNFTMarketplace", () => {
    let basicNftMarketplace: Contract;

    before(async () => {
        const basicNFTMarketplace = await ethers.getContractFactory("BasicNFTMarketplace");
        const basicNftMarketplace = await basicNFTMarketplace.deploy();
    });
});

describe("BasicNFTMarketplace", () => {
    it("Should do something", async () => {
      const basicNFTMarketplace = await ethers.getContractFactory("BasicNFTMarketplace");
      const basicNftMarketplace = await basicNFTMarketplace.deploy();
      //await basicNftMarketplace.deployed();

      const tokenURI = "https://some-token.uri/";
      const transaction = await basicNftMarketplace.createNFT(tokenURI);
      const receipt = await transaction.wait();
      
      /*
      const tokenID = receipt.events[0].args.tokenId;
      const mintedTokenURI = await basicNftMarketplace.tokenURI(tokenID);
      expect(mintedTokenURI).to.equal(tokenURI);

      const ownerAddress = await basicNftMarketplace.ownerOf(tokenID);
      const signers = await ethers.getSigners();
      const currentAddress = await signers[0].getAddress();
      expect(ownerAddress).to.equal(currentAddress);
      */
    });
});