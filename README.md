# AWS Instance Scheduler

[English version guide](README-en.md)

## 方案概述
Amazon Web Services（AWS）按需提供云资源，以便客户可以控制其资源容量并随需付费。降低成本的一种方法是停止未使用的资源，并在需要其容量时启动这些资源。

AWS Instance Scheduler 是其中一种解决方案，可让客户轻松配置自定义启动和停止时间表并自动启动（需要资源容量时）和停止
（未使用的资源）Amazon Elastic Compute Cloud（Amazon EC2）和 Amazon Relational Database Service（Amazon RDS）实例。

AWS Instance Scheduler 利用AWS资源标签和 AWS Lambda 函数自动按照存储在 Amazon DynamoDB 中的客户定义的时间计划表对跨多个AWS区域和多个账户的实例进行停止和重启。 Amazon CloudWatch 事件触发一个 AWS Lambda 函数，该函数检查每个带有适当标签的实例的当前状态, 并执行计划表中的动作。

Lambda 函数还在 Amazon DynamoDB 中记录时间计划表的名称，与该时间计划表关联的实例以及实例的状态。

## 方案架构

![](resource/images/instance-scheduler-architecture.png)

用于 EC2 和 RDS 实例按计划启停调度，支持跨帐户和跨区域调度。
此存储库来自 https://github.com/awslabs/aws-instance-scheduler 并基于v1.3.0版本在中国区域进行了更新。 

## 快速启动：参考下面文档部署 Cloudformation 模板和执行示例演示

[如何部署 cloudformation 和 执行示例演示帮助文档](Testing.md)


## 定制自己的instance-scheduler，并部署新的方案
如果您打算修改本方案，加入您定制化的内容，可以通过Makefile生成的新的Cloudformation模板以及相关资源，进行部署。

定制化编译和部署包括一下内容：
1. 生成新的 AWS Instance Scheduler Cloudformation 模板
2. 打包新的 AWS Instance Scheduler Lambda 函数代码
3. 上传新的构件到用户指定的 S3 桶。

基本步骤如下，编译命令在 Amazon Linux, Ubuntu, MacOS 环境下验证通过：

1. git克隆这个仓库
```bash
# git 克隆
git clone https://code.awsrun.com/csdc/aws-instance-scheduler.git
cd aws-instance-scheduler/source/code/
```

2. 确保你的运行机器安装了 aws cli, pip, zip 命令 以及 pytz库
```bash
# 安装 pytz 库
pip install pytz
pytz_location=$(pip show pytz | grep Location | cut -d':' -f 2 | tr -d " ")
cp -r ${pytz_location}/pytz .
```
3. 修改代码，加入您的内容

4. 运行make命令，您可以指定{s3_bucket}和{region}
```bash
# 编译
## 定义下列变量：bucket, solution, version, region
export bucket=YOUR_S3_BUCKET //This bucket must unique 该S3桶必须唯一
export solution=THE_SOLUTION_NAMING
export version=THE_VERSION
export region=THE_REGION_OF_S3_BUCKET_LOCATED
make bucket=${bucket} solution=${solution} version=${version} region=${region}
## for example: make bucket=solutions-scheduler solution=aws-instance-scheduler version=v1.3.0 region=cn-northwest-1

# 通过 aws cli (版本建议 1.18以上)设置 S3 桶 PublicAccessBlock 配置
aws s3api put-public-access-block \
    --bucket ${bucket} \
    --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" --region ${region}

# 部署
make deploy bucket=${bucket} solution=${solution} version=${version} region=${region}
# for example: make deploy bucket=solutions-scheduler solution=aws-instance-scheduler version=v1.3.0 region=cn-northwest-1

# 删除 pytz 库
rm -r pytz
```

## 编译和部署成功执行了哪些动作？
- 如果S3存储桶不存在，那么新的S3存储桶 ${bucket}-${region} 将会被创建
- 资源将自动上传到 s3://${bucket}-${region}/${solution}/${version}/
- S3存储桶公共访问阻止策略为：BlockPublicAcls = false，IgnorePublicAcls = true，BlockPublicPolicy = true，RestrictPublicBuckets = true


***

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

    http://www.apache.org/licenses/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or implied. See the License for the specific language governing permissions and limitations under the License.
