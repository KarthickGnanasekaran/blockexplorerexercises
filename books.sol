// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Books {

    mapping (uint=>book) bookDetails;

    struct book{        
        uint256 bookId;
        address addedBy;
        string  bookName;
        bool isExist;       
    }

    function storeBook(uint _bookId, address _addedBy,string memory _bookname) public
    {
        bookDetails[_bookId]=book(_bookId,_addedBy,_bookname,true);
    }

    function showBook(uint _bookId) public view returns(uint, address, string memory){
        return(bookDetails[_bookId].bookId,bookDetails[_bookId].addedBy,bookDetails[_bookId].bookName);
    }
}
