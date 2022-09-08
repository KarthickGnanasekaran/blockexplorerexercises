//SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

contract Vendingmachine {
    address public owner;
    mapping(address => uint) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 10;
        }
    function getvendingmachineBalance() public view returns(uint){
        return donutBalances[address(this)];
    }        

    function restock(uint amount) public {
        donutBalances[address(this)] += amount;
    }

    function purchaseDonut(uint amount) public payable {
        require (msg.value >= amount * 2 ether, "Amount insufficient");
        require (donutBalances[address(this)] >= amount, "Donut not enough stock");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    } 
}
