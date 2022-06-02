# build fisco

## 1. deploy
1. openssl
2. curl
### ubuntu install
```bash
sudo apt install -y openssl curl
```
## 2. folder and script
```bash
# create folder
cd ~ ; mkdir -p fisco ; cd fisco

# download and install script
curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/releases/v2.9.0/build_chain.sh && chmod u+x build_chain.sh
```

## 3. build *Consortium Blockchain* only group of 4 node 
> don't port `30300~30303, 20200~20203, 8545~8548` by used

### build
```bash
bash build_chain.sh -l 127.0.0.1:4 -p 30300,20200,8545
```

- `-p` => port of start

#### success
> if build to success by console on out `All completed`
> 

```bash
Checking fisco-bcos binary...
Binary check passed.
==============================================================
Generating CA key...
==============================================================
Generating keys ...
Processing IP:127.0.0.1 Total:4 Agency:agency Groups:1
==============================================================
Generating configurations...
Processing IP:127.0.0.1 Total:4 Agency:agency Groups:1
==============================================================
[INFO] Execute the download_console.sh script in directory named by IP to get FISCO-BCOS console.
e.g.  bash /home/ubuntu/fisco/nodes/127.0.0.1/download_console.sh
==============================================================
[INFO] FISCO-BCOS Path   : bin/fisco-bcos
[INFO] Start Port        : 30300 20200 8545
[INFO] Server IP         : 127.0.0.1:4
[INFO] Output Dir        : /home/ubuntu/fisco/nodes
[INFO] CA Key Path       : /home/ubuntu/fisco/nodes/cert/ca.key
==============================================================
[INFO] All completed. Files in /home/ubuntu/fisco/nodes
Copy to clipboard
```

## run fisco chian
### run all nodes
```bash
bash nodes/127.0.0.1/start_all.sh
```
#### run 
```bash
try to start node0
try to start node1
try to start node2
try to start node3
 node1 start successfully
 node2 start successfully
 node0 start successfully
 node3 start successfully
```

# 配置及使用控制台
> 在控制台链接 FISCO BCOS 节点，实现查询区块链状态、部署调用合约等功能，能够快速获取到所需要的信息
> 

## 依赖
- java (jdk8 以上)

- 获取控制台
```bash
 cd ~/fisco && curl -#LO https://gitee.com/FISCO-BCOS/console/raw/master-2.0/tools/download_console.sh && bash download_console.sh
```

- 拷贝控制台配置文件
```bash
# 最新版本控制台使用如下命令拷贝配置文件
cp -n console/conf/config-example.toml console/conf/config.toml
```

- 配置控制台证书
```bash
cp -r nodes/127.0.0.1/sdk/* console/conf/
```

## 启动并使用控制台
- 启动
```bash
cd ~/fisco/console && bash start.sh

=============================================================================================
Welcome to FISCO BCOS console(2.6.0)！
Type 'help' or 'h' for help. Type 'quit' or 'q' to quit console.
 ________  ______   ______    ______    ______         _______    ______    ______    ______
|        \|      \ /      \  /      \  /      \       |       \  /      \  /      \  /      \
| $$$$$$$$ \$$$$$$|  $$$$$$\|  $$$$$$\|  $$$$$$\      | $$$$$$$\|  $$$$$$\|  $$$$$$\|  $$$$$$\
| $$__      | $$  | $$___\$$| $$   \$$| $$  | $$      | $$__/ $$| $$   \$$| $$  | $$| $$___\$$
| $$  \     | $$   \$$    \ | $$      | $$  | $$      | $$    $$| $$      | $$  | $$ \$$    \
| $$$$$     | $$   _\$$$$$$\| $$   __ | $$  | $$      | $$$$$$$\| $$   __ | $$  | $$ _\$$$$$$\
| $$       _| $$_ |  \__| $$| $$__/  \| $$__/ $$      | $$__/ $$| $$__/  \| $$__/ $$|  \__| $$
| $$      |   $$ \ \$$    $$ \$$    $$ \$$    $$      | $$    $$ \$$    $$ \$$    $$ \$$    $$
 \$$       \$$$$$$  \$$$$$$   \$$$$$$   \$$$$$$        \$$$$$$$   \$$$$$$   \$$$$$$   \$$$$$$

=============================================================================================
```

## 控制台命令

### getNodeVersion

```bash
# 获取客户端版本
getNodeVersion

[group:1]> getNodeVersion
ClientVersion{
    version='2.8.0',
    supportedVersion='2.8.0',
    chainId='1',
    buildTime='20210830 12:52:15',
    buildType='Linux/clang/Release',
    gitBranch='HEAD',
    gitCommitHash='30fb38ac5692468058abf6aa12869d2ae776c275'
}
```

### getPeers

```bash
getPeers
[
    PeerInfo{
        nodeID='1a9ab4e15f3f810b73354017b90194d9d0e0cbb02009feb1762b67f731d566e404b137eb7aabb12a14902bbcf7d1d54dd4525be3cac966ceeb84de9e4da20d1f',
        iPAndPort='127.0.0.1:47126',
        node='node3',
        agency='agency',
        topic='[

        ]'
    },
    PeerInfo{
  ...
]
```

### deploy

```bash
[group:1]> deploy HelloWorld
transaction hash: 0xd0305411e36d2ca9c1a4df93e761c820f0a464367b8feb9e3fa40b0f68eb23fa
contract address:0xb3c223fc0bf6646959f254ac4e4a7e355b50a344
```

- 合约地址 ~/fisco/console/contracts/solidity
- deploy <constract>

### getBlockNumber

```bash
[group:1]> getBlockNumber
3
```

### call 调用合约变量

- call <contract name> <contract addr> <contract methods>  <contract parameter>

```bash
[group:1]> call HelloWorld  0x4b28b16f31b6af3c27998e27714ca3545364fe2b set "ask"
transaction hash: 0xac7ee358275135a09b9676532a5760b2d98cd73ec56d680ff738c8b6e6d3a0cc
---------------------------------------------------------------------------------------------
transaction status: 0x0
description: transaction executed successfully
---------------------------------------------------------------------------------------------
Receipt message: Success
Return message: Success
Return values:[]
---------------------------------------------------------------------------------------------
Event logs
Event: {}

[group:1]> call HelloWorld  0x4b28b16f31b6af3c27998e27714ca3545364fe2b get
---------------------------------------------------------------------------------------------
Return code: 0
description: transaction executed successfully
Return message: Success
---------------------------------------------------------------------------------------------
Return value size:1
Return types: (STRING)
Return values:(ask)
---------------------------------------------------------------------------------------------

[group:1]> getBlockNumber
5
```