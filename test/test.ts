import { ethers } from "hardhat";


describe("BasicNFTMarketplace", () => {
    it("Should do something", async () => {
      const basicNFTMarketplace = await ethers.getContractFactory("BasicNFTMarketplace");
      const basicNftMarketplace = await basicNFTMarketplace.deploy();
      //await basicNftMarketplace.deployed();

      const tokenURI = "";
      const transaction = await basicNftMarketplace.createNFT(tokenURI);
      console.log(transaction);
      const receipt = await transaction.wait();
    });
});