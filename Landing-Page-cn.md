# AWS 实例调度器

[查看部署指南](http://docs.aws.amazon.com/solutions/latest/instance-scheduler/welcome.html)

## 此 AWS 解决方案有何用途？

Amazon Web Services（AWS）提供按需供给的基础架构，以便客户可以控制其资源容量并仅支付其消费量。降低成本的一种简单方法是停止未使用的资源，然后在需要其容量时再次启动这些资源。

AWS 实例调度器是 AWS 提供的简单解决方案，使客户能够轻松地为其 Amazon Elastic Compute Cloud（Amazon EC2）和 Amazon Relational Database Service（Amazon RDS）实例配置自定义启动和停止时间表。该解决方案易于部署，可以帮助降低开发和生产环境的运营成本。与每天 24 小时运行实例相比，使用该解决方案在正常工作时间运行实例的客户最多可节省 70％。

该网页概述了实例计划程序的设计和功能。

## AWS 解决方案概述

AWS 提供了一个简单的解决方案，可让您为 Amazon EC2 和 Amazon RDS 实例创建自动启动和停止时间表。 下图显示了实例调度器的架构组件，您可以使用实施指南和随附的 AWS CloudFormation 模板构建的组件和功能。

[点击放大](https://code.awsrun.com/csdc/aws-instance-scheduler/media/branch/aws-cn/resource/images/instance-scheduler-architecture.png)

### AWS 实例调度器架构

使用 Amazon CloudWatch 事件触发一个 AWS Lambda 函数，该函数将根据 Amazon DynamoDB 表中关联的调度计划中定义的目标状态去检查每个适当标记的实例的当前状态，然后根据定义的时间计划，Lambda 函数将对适用的实例执行启动或停止操作。

Lambda 函数还会在 Amazon CloudWatch 中记录计划的名称，与该计划关联的实例数以及正在运行的实例数作为可选的自定义指标。

[阅读更多](https://aws.amazon.com/solutions/implementations/instance-scheduler/#)

## AWS 实例调度器

版本 1.3.0

上次更新日期：2020 年 4 月

作者：AWS

预计部署时间：10 分钟

[源代码](https://code.awsrun.com/csdc/aws-instance-scheduler)

[CloudFormation 模板](https://code.awsrun.com/csdc/aws-instance-scheduler)

[查看部署指南](https://docs.aws.amazon.com/solutions/latest/instance-scheduler/welcome.html)

[在 AWS 控制台中启动解决方案](https://cn-northwest-1.console.amazonaws.cn/cloudformation/home?region=cn-northwest-1#/stacks/new?templateURL=https:%2F%2Fsolutions-scheduler.s3.cn-northwest-1.amazonaws.com.cn%2Faws-instance-scheduler%2Fv1.3.0%2Finstance-scheduler.template)

## 部署资源

[下载部署指南](https://s3.amazonaws.com/solutions-reference/aws-instance-scheduler/latest/instance-scheduler.pdf)

[AWS 解决方案资源](https://aws.amazon.com/solutions/implementations/instance-scheduler/resources/) »

[联系我们](https://aws-china-preview.aka.amazon.com/contact-us/) »

使用下面的按钮订阅解决方案更新

[订阅 RSS 源](https://solutions-reference.s3.amazonaws.com/aws-instance-scheduler/latest/rss.xml)

注意：要订阅 RSS 更新，您必须为您正在使用的浏览器启用一个 RSS 插件。

[为此解决方案评分](https://d3j2ena7q16udu.cloudfront.net/rate-this-solution.html)

## 功能

### 跨账号实例调度

该解决方案包括一个 CloudFormation 模板，该模板可创建启动和停止辅助帐户中的实例所需的 AWS Identity and Access Management（IAM）角色以及自动添加在主账户中的信任关系。

### 调度器命令行工具

该解决方案包括一个命令行界面（CLI），该命令行工具提供用于配置计划和时间段的命令。 CLI 使客户可以评估给定计划的成本节省。

### 自动化标签

实例计划程序可以自动将标签添加到其启动或停止的所有实例中。 该解决方案还包括允许您将变量信息添加到标签的宏。

### 自动化

方案部署通过 CloudFormation 自动完成，通过调度器命令行工具，自动创建调度计划和时间段。
