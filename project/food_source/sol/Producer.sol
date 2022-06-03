//测试：单体功能测试时，直接使用发送者的地址初始化
pragma abicoder ^0.4.25;

import "./Roles.sol";

//生产商
contract Producer {
    //使用自建的库，角色处理
    using Roles for Roles.Role;

    Roles.Role private _producers;

    //初始化，并且创建一个角色，
    constructor (address producer) public {
        _addProducer(producer);
    }

    //检查发送者是否是已存在的生产商
    modifier onlyProducer() {
        require(isProducer(msg.sender), "ProducerRole:caller does not hava the Producer role");
        _;
    }

     //判断该生产商是否存在
    function isProducer(address account) public view returns(bool) {
        return _producers.has(account);
    }
     
     //封装添加生产商方法
    function addProducer(address account) public onlyProducer{
        return _producers.add(account);
    }

    //自主注销
    function renounceProducer() public {
        _removeProducer(msg.sender);
    }

    //添加生产商的底层方法
    function _addProducer(address account) internal {
        _producers.add(account);
    }

    //删除生产商的底层方法
    function _removeProducer(address account) internal {
        _producers.remove(account);
    }
 
}