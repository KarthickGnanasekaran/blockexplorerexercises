// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Enumex1 {
    enum insuranceStatus {
        Pending,
        Active,
        Expired,
        Cancelled
    }

    insuranceStatus public status;

    function get() public view returns(insuranceStatus){
    return status;
    }

    function set() public {
        status = insuranceStatus.Active;
    }

    function reset() public {
        delete status;
    }

    function update(insuranceStatus _status) public {
        status = _status;
    }
}
