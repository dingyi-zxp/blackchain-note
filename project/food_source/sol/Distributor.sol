//测试：单体功能测试时，直接使用发送者的地址初始化

pragma solidity ^0.4.25;

import "./Roles.sol";

// 经销商
contract Distributor {

    //使用自建的库，角色处理
    using Roles for Roles.Role;
    
    Roles.Role private _distributors;

    //初始化，并且创建一个角色，
    constructor (address distributor) public {
        _addDistributor(distributor);
    }

   //检查发送者是否是已存在的经销商
    modifier onlyDistrributor() {
        require(isDistributor(msg.sender),"DistributorRole:caller does not hava the Distributor role");
        _;
    }

    //判断该经销商是否存在
    function isDistributor(address account) public view returns (bool) {
        return _distributors.has(account);
    }

    //封装添加经销商方法
    function addDistributor(address account) public onlyDistrributor {
        _addDistributor(account);
    }

    //自主注销
    function renounceDistributor() public {
        _removeDistributor(msg.sender);
    }

    //添加经销商的底层方法
    function _addDistributor(address account) internal {
        _distributors.add(account);
    }

    //删除经销商
    function _removeDistributor(address account) internal {
        _distributors.remove(account);
    }
}