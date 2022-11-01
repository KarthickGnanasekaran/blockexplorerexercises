// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Marinerescuers {

  /*  enum InsurancePeriod {
        TESTNOW,
        MONTH12,
        MONTH24
    } 

    enum Status {
        PENDING,
        APPROVED,
        REJECTED,
        EXPIRED
    } */

    address public contractOwner;
    uint256 public fishermanId;
    // uint256 public insuranceId;
    uint256 public liquidityPool;
    //uint256 private endDate;
    // address payable insuranceBuyer;
    // Status public insuranceStatus = Status.PENDING;

    struct fishermanInfo {
          address payable fishermanaddress;
          uint256 fishermanId;
    //    uint256 obdId;
    //    uint256 vehicleRegNo;
    //    string vehicleType;
    //    uint256 yearOfManufacture;
          string location;
    }
    /*
    struct InsuranceInfo {
        address payable insuranceHolder;
        uint256 vehicleId;
        uint256 insuranceId;
        uint256 endDate;
        Status status;
    } */


    mapping(uint => fishermanInfo) public fishermanDetail;
    // mapping(uint => InsuranceInfo) public InsuranceDetail;

  //  event buyPolicyEvent(uint256 vehicleId, uint256 insuranceId, address payable insuranceBuyer, uint256 endDate);

    constructor() {
        contractOwner = msg.sender;
        liquidityPool = 1000 ether;
        fishermanId = 1;
    //    insuranceId = 1;
    }

    modifier onlyOwner() {
        require(contractOwner == msg.sender, "Access Forbidden. Only Contract Owner Can Access!");
        _;
    }

    function registerfisherman(
       // uint256 _vehicleRegNo, 
       // uint256 _obdId, 
       // string memory _vehicleType,
       // uint256 _yearOfManufacture, 
        string memory _location
        ) public onlyOwner {
            fishermanDetail[fishermanId] = fishermanInfo(payable(msg.sender), fishermanId, 
            _location);
        
            fishermanId += 1;
        }

/*
    function buyInsurance(uint256 _period) public payable {

        require(insuranceStatus == Status.PENDING, "Already purchased the Insurance");

       if (InsurancePeriod.TESTNOW == InsurancePeriod(_period)) {
            endDate = block.timestamp + 50 seconds;
        }
        else if (InsurancePeriod.MONTH12 == InsurancePeriod(_period)) {
            require(msg.value == 50 ether, "Insufficient value, Please pay 50 XDC");
            endDate = block.timestamp + 360 days;
        }
        else if (InsurancePeriod.MONTH24 == InsurancePeriod(_period)) {
            require(msg.value == 75 ether, "Insufficient value, Please pay 75 XDC");
            endDate = block.timestamp + 720 days;
        }
        
        insuranceBuyer = payable(msg.sender);

        liquidityPool += msg.value;

        InsuranceDetail[insuranceId] = InsuranceInfo(insuranceBuyer, vehicleId, insuranceId,
        endDate, Status(1));

        insuranceStatus = Status.APPROVED;

        insuranceId += 1;
        emit buyPolicyEvent(vehicleId, insuranceId, insuranceBuyer, endDate);
    }
*/
    function rewardCalculation(uint256 _plasticWeight) public pure returns(uint256) {
        uint256 reward;
        reward = _plasticWeight * 0.01 ether;
        return reward;
    }

    function getReward(uint256 _fishermanId, uint256 _plasticWeight) public payable returns (uint256){
          address payable fishermanaddr = fishermanDetail[_fishermanId].fishermanaddress;
      //  require(insuranceHolder == msg.sender);
      //  require(insuranceStatus == Status.APPROVED, "Please buy the Insurance");

        uint256 myReward = rewardCalculation(_plasticWeight);        
        require(liquidityPool >= myReward, "Insufficient Liquidity Pool Balance!");
        fishermanaddr.transfer(myReward);
        liquidityPool -= myReward;
        return myReward;
    }

    // Accounting functions
    function addToBalance() 
    public payable 
    {}
    
    function getBalance() 
    public onlyOwner view returns(uint256) {
        return address(this).balance;
    }

    function withdrawAll() 
    public onlyOwner {
        address payable to = payable(contractOwner);
        to.transfer(getBalance());
    }

    function withdrawAmount(uint256 amount) 
    public onlyOwner {
        address payable to = payable(msg.sender);
        to.transfer(amount);
    }


}
