import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("RuckPlus", function () {
  async function deployOneYearLockFixture() {
    const [owner, otherAccount] = await ethers.getSigners();

    const RuckPlus = await ethers.getContractFactory("RuckPlus");
    const contract = await RuckPlus.deploy();

    return { contract, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should set the right unlockTime", async function () {
      const { contract } = await loadFixture(deployOneYearLockFixture);

      expect(await contract.unlockTime()).to.equal(unlockTime);
    });
  });
});
