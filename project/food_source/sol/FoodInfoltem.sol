pragma solidity >=0.4.22 <0.5.0;
pragma experimental ABIEncoderV2;

contract FoodInfoItem{
    uint[] _timestamp;      //保存食品
    string[] _traceName;    
    address[] _traceAddress; 
    uint8[] _traceQuality;  
    string _name;  
    string _currentTraceName;  
    uint8 _quality; 
    uint8 _status; 
    address  _owner;

  constructor (string name, string traceName, uint8 quality, address producer) public {
        _timestamp.push(now);
        _traceName.push(traceName);
        _traceAddress.push(producer);
        _traceQuality.push(quality);
        _name = name;
        _currentTraceName = traceName;
        _quality = quality;
        _status = 0;
        _owner = msg.sender;
    }

    function addTraceInfoByDistributor( string traceName, address distributor, uint8 quality) public returns(bool) {
        require(_status == 0 , "status must be producing");
        require(_owner == msg.sender, "only trace contract can invoke");
        _timestamp.push(now);
        _traceName.push(traceName);
        _currentTraceName = traceName;
        _traceAddress.push(distributor);
        _quality = quality;
        _traceQuality.push(_quality);
        _status = 1;
        return true;
    }

    function addTraceInfoByRetailer( string traceName, address retailer, uint8 quality) public returns(bool) {
        require(_status == 1 , "status must be distributing");
        require(_owner == msg.sender, "only trace contract can invoke");
        _timestamp.push(now);
        _traceName.push(traceName);
        _currentTraceName = traceName;
        _traceAddress.push(retailer);
        _quality = quality;
        _traceQuality.push(_quality);
        _status = 2;
        return true;
    }

    function getTraceInfo() public constant returns(uint[], string[], address[], uint8[]) {
        return(_timestamp, _traceName, _traceAddress, _traceQuality);
    }

    function getFood() public constant returns(uint, string, string, string, address, uint8) {
        return(_timestamp[0], _traceName[0], _name, _currentTraceName, _traceAddress[0], _quality);
    }

}