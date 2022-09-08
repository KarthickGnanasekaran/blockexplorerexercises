//SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

contract Greeting {
    string public firstname;
    string public lastname;
    string salutation = "Hello ";

    constructor(string memory _firstname, string memory _lastname){
        firstname = _firstname;
        lastname = _lastname;
    }

    function newname (string memory _newfirstname, string memory _newlastname)public{
        firstname = _newfirstname;
        lastname = _newlastname;
    }

    function getname() public view returns(string memory){
        return string(abi.encodePacked(salutation, firstname,lastname));
    }
    
}
