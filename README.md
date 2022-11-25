# 基于Polygon的大海筹（众筹）项目

主要功能：
1. 发布众筹：
    - 地址
    - 姓名
    - 原因
    - 目标金额
2. 捐款
3. 查看捐款人数和列表
4. 查看当前捐款钱数

主要技术：
- Polygon
- 前端：[Bootstrap5](https://bootstrapdoc.com/)

合约端开发步骤：
1. 在remix编写Solidity合约
2. 部署合约到Polygon网络，保存abi文件放在本项目的abi文件夹下
3. 配置文件conf/base_conf.js内容
4. 将page/index.html放在服务器后直接访问

前端开发步骤：
1. 开发代码对合约进行调用
