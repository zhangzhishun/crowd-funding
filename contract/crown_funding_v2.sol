pragma solidity ^0.4.18;

contract CrowdFunding {

    // 赞助人
    struct Funder {
        // 赞助人地址
        address funderAddr;
        // 捐赠的数额
        uint money;
    }

    // 筹集人
    struct Needer {
        // 筹集人地址
        address neederAddr;
        // 姓名
        string name;
        // 筹集资金原因
        string reason;
        // 众筹的目标资金
        uint goal;
        // 目前筹集到的资金
        uint current;
        // 赞助人数
        uint funderAmount;
        // 赞助人详细信息
        mapping(uint => Funder) funderMap;
        // 赞助人地址列表
        address[] funderAddress;
    }

    // owner
    address private owner;
    // 合约属性
    string private contractName;
    // 筹集人编号
    uint neederAmount;
    // 筹集人与编号的映射关系
    mapping(uint => Needer) neederMap;


    // 检查调用者是否为本人
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    // 新建筹集人事件
    event NewNeederEvent(address indexed needer);

    // 构造方法
    constructor(string name) public {
        contractName = name;
        owner = msg.sender;
        neederAmount = 1;
    }

    // 设置合约名字
    function setContractName(string name) isOwner public {
        contractName = name;
    }

    // 获取合约名字
    function getContractName() view public returns (string) {
        return contractName;
    }

    // 赞助
    function contribute(uint neederId) public payable {
        Needer storage needer = neederMap[neederId];
        needer.current += msg.value;
        needer.funderAmount++;
        needer.funderMap[needer.funderAmount] = Funder(msg.sender, msg.value);
        needer.funderAddress.push(msg.sender);
        needer.neederAddr.transfer(msg.value);
    }

    // 创建筹集人
    function newNeeder(string name, string reason, uint goal) public {
        neederAmount++;
        neederMap[neederAmount] = Needer(msg.sender, name, reason, goal, 0, 0,new address[](0));
        emit NewNeederEvent(msg.sender);
    }

    // 查看某一筹集人信息
    function showNeeder(uint neederId) view public returns(address, string, string, uint, uint, uint, address []){
        Needer storage needer = neederMap[neederId];
        return(needer.neederAddr, needer.name, needer.reason, needer.goal, needer.current, needer.funderAmount, needer.funderAddress );
    }

}