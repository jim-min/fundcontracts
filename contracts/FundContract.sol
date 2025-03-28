// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract FundContract {
    constructor() {}

    struct Campaign {
        address owner;
        string title;
        string description;
        uint target;
        uint deadline;
        uint percentageCollected;
        string image;
        address[] donators;
        address[] donations;
    }

    mapping (uint => Campaign) public campaigns;
    uint public numOfCampaigns = 0;
    
    function createCampaign(address _owner, string memory _title, string memory _description, uint) public {

    }

    function donateToCampaign() public {

    }

    function getDonators() public {

    }

    function getCampaigns() public {

    }
}