pragma solidity ^0.4.25;

//角色
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }
    
    //添加
    function add(Role storage role ,address account) internal {
        
        require(!has(role,account), "Roles:account does already has role");
        role.bearer[account] = true;
    }
    
    //删除
    function remove(Role storage role ,address account) internal {
        
        require(has(role,account),"Roles account does not have role");
        role.bearer[account]= false;
    }

    //判断该用户地址是否已存在
    function has(Role storage role,address account) internal view returns(bool) {
        //实际的Solidity代码语句 address (0) ，它是类型为 address 的变量的初始值
        require(account != address(0),"Roles:account is the zero address");
        return role.bearer[account];
    }
    
}