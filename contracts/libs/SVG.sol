// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {BytesArray} from "bytes-array.sol/BytesArray.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

library SVG {
    using Strings for uint;
    using BytesArray for bytes[];

    struct Attribute {
        string key;
        string value;
    }

    struct Element {
        bytes head;
        bytes tail;
        Attribute[] attrs;
    }

    function react(int _x, int _y, uint _width, uint _height) internal pure returns (Element memory element) {
        element.head = abi.encodePacked(
            '<rect x="',
            uint(_x).toString(),
            '" y="',
            uint(_y).toString(),
            '" width="',
            _width.toString(),
            '" height="',
            _height.toString()
        );
        element.tail = '"/>\n';
    }

    function svg(Element memory _element) internal pure returns (bytes memory output) {
        if (_element.head.length > 0) {
            output = _element.head;
            for (uint i = 0; i < _element.attrs.length; i++) {
                Attribute memory attr = _element.attrs[i];
                output = abi.encodePacked(output, '" ', attr.key, '="', attr.value);
            }
        } else {
            require(_element.attrs.length == 0, 'Attributes on list');
        }
        output = abi.encodePacked(output, _element.tail);
    }

    function document(
        string memory _viewBox,
        bytes memory _body
    ) internal pure returns (string memory) {
        bytes memory output = abi.encodePacked(
            '<?xml version="1.0" encoding="UTF-8"?>',
            '<svg viewBox="',
            _viewBox,
            '" xmlns="http://www.w3.org/2000/svg">\n'
        );
        output = abi.encodePacked(output, _body, '</svg>\n');
        return string(output);
    }
}
