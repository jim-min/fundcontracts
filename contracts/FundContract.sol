// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract FundContract {
    // Use SafeMath for uint
    
    constructor() {}

    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    mapping (uint => Campaign) public campaigns;
    uint public numOfCampaigns = 0;
    
    function createCampaign(address _owner, string memory _title, string memory _description, uint _target, uint _deadline, string memory _image) public returns (uint){
        Campaign storage campaign = campaigns[numOfCampaigns];

        require(campaign.deadline < block.timestamp, "Deadline cannot be in the past");

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.image = _image;
        campaign.amountCollected = 0;

        numOfCampaigns = numOfCampaigns++;
        return numOfCampaigns - 1;
    }

    function donateToCampaign(uint _campaignId) public payable {
        uint amount = msg.value;

        Campaign storage campaign = campaigns[_campaignId];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent, ) = payable(campaign.owner).call{value : amount}("");

        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    function getDonators(uint _campaignId) public view returns (address[] memory, uint256[] memory) {
        return (campaigns[_campaignId].donators, campaigns[_campaignId].donations);
    }

    function getCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numOfCampaigns);

        for (uint i = 0; i < numOfCampaigns; i++) {
            Campaign storage item = campaigns[i];

            allCampaigns[i] = item;
        }

        return allCampaigns;
    }
}