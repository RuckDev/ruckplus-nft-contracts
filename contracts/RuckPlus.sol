// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721A} from "erc721a/contracts/ERC721A.sol";
import {SVG} from "./libs/SVG.sol";

// Uncomment this line to use console.log
import "hardhat/console.sol";

error InvalidTokenId(uint256 tokenId);

/// @title RuckPlus
/// @author 0xpokotaro
contract RuckPlus is ERC721A {
    constructor() ERC721A("RuckPlus", "RUCK") {}

    function mint(uint256 _quantity) public {
        _mint(msg.sender, _quantity);
    }

    function buildImage(uint256 _tokenId) public pure returns (string memory) {
        console.log(_tokenId);
        return SVG.document(
            "0 0 512 512",
            SVG.react(128, 175, 255, 162).svg()
        );
    }

    function buildMetadata(uint256 tokenId) public pure returns (string memory) {
        console.log(tokenId);
        return "";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        if (!_exists(tokenId)) revert InvalidTokenId(tokenId);
        return buildMetadata(tokenId);
    }

    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }
}
