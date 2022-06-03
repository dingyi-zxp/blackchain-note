//测试：单体功能测试时，直接使用发送者的地址初始化


pragma solidity ^0.4.25;

import "./Roles.sol";

//零售商
contract Retailer {
    
    //使用自建的库，角色处理
    using Roles for Roles.Role;

    Roles.Role private _retailers;

    //初始化，并且创建一个角色，
    constructor (address retailer) public {   //这里最好使用public
        _addRetailer(retailer);
    }

    //检查发送者是否是已存在的零售商
    modifier onlyRetailer() {
        require(isRetailer(msg.sender), "RetailerRole: caller does not have the Retailer role");
        _;
    }

    //判断该零售商是否存在
    function isRetailer(address account) public view returns (bool) {
        return _retailers.has(account);
    }

    //封装添加零售商方法
    function addRetailer(address account) public onlyRetailer {
        _addRetailer(account);
    }

    //检查发送者是否是已存在的零售商
    function renounceRetailer() public {
        _removeRetailer(msg.sender);
    }

    //添加零售商的底层方法
    function _addRetailer(address account) internal {
        _retailers.add(account);
      
    }

    //删除零售商的底层方法
    function _removeRetailer(address account) internal {
        _retailers.remove(account);
      
    }
}