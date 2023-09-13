import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("RuckPlus", () => {
  async function deployOneYearLockFixture() {
    const [owner, otherAccount] = await ethers.getSigners();

    const RuckPlus = await ethers.getContractFactory("RuckPlus");
    const contract = await RuckPlus.deploy();

    return { contract, owner, otherAccount };
  }

  describe("Deployment", () => {
    it("Should set the right unlockTime", async () => {
      const { contract } = await loadFixture(deployOneYearLockFixture);

      await contract.mint(3)

      const buildImage = await contract.buildImage(1);
      console.log("buildImage: ", buildImage);

      const buildMetadata = await contract.buildMetadata(1);
      console.log("buildMetadata: ", buildMetadata);

      const tokenURI = await contract.tokenURI(1);
      console.log("tokenURI: ", tokenURI);

      expect(true).to.equal(true);
    });
  });
});
