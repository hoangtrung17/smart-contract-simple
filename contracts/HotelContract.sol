pragma solidity ^0.6.0;

contract TonyHotel {
    //Available
    //Occupied
    enum Statuses { Available, Occupied }

    Statuses roomStatus;
    
    address payable public owner;
    
    constructor() public {
        owner = msg.sender;
        roomStatus = Statuses.Available;
    }
    
    event Occupy(address _occupant, uint _value);
    
    modifier availableRoom() {
        require(roomStatus == Statuses.Available, "Room is occupied");
        _;
    }
    
    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enought costs require");
        _;
    }
    
    receive() external payable availableRoom costs(2 ether){
        roomStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}