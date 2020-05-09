# AWS Instance Scheduler

[View deployment guide](http://docs.aws.amazon.com/solutions/latest/instance-scheduler/welcome.html)

## What does this AWS Solution Implementation do?

Amazon Web Services (AWS) offers infrastructure on demand so that customers can control their resource capacity and pay only for what they consume. One simple method to reduce costs is to stop resources that are not in use, and then start those resources again when their capacity is needed.

The AWS Instance Scheduler is a simple AWS-provided solution that enables customers to easily configure custom start and stop schedules for their Amazon Elastic Compute Cloud (Amazon EC2) and Amazon Relational Database Service (Amazon RDS) instances. The solution is easy to deploy and can help reduce operational costs for both development and production environments. Customers who use this solution to run instances during regular business hours can save up to 70% compared to running those instances 24 hours a day.

This webpage provides an overview of the Instance Scheduler design and functionality.

## AWS Solution Implementation overview

AWS offers a simple solution that allows you to create automatic start and stop schedules for your Amazon EC2 and Amazon RDS instances. The diagram below presents the components and functionality you can build using the Instance Scheduler implementation guide and accompanying AWS CloudFormation template.

[Click to enlarge](https://code.awsrun.com/csdc/aws-instance-scheduler/media/branch/aws-cn/resource/images/instance-scheduler-architecture.png)

### AWS Instance Scheduler architecture

An Amazon CloudWatch event triggers an AWS Lambda function that checks the current state of each appropriately tagged instance against the targeted state defined in an associated schedule in Amazon DynamoDB. Then, the Lambda function applies the applicable start or stop action to the instance.

The Lambda function also records the name of the schedule, the number of instances associated with that schedule, and the number of running instances as an optional custom metric in Amazon CloudWatch.

[Read more](https://aws.amazon.com/solutions/implementations/instance-scheduler/#)

## AWS Instance Scheduler

Version 1.3.0

Last updated: 03/2020

Author: AWS

Estimated deployment time: 10 min

[Source code](https://code.awsrun.com/csdc/aws-instance-scheduler)

[CloudFormation template](https://code.awsrun.com/csdc/aws-instance-scheduler)

[View deployment guide](https://docs.aws.amazon.com/solutions/latest/instance-scheduler/welcome.html)

[Launch in the AWS Console](https://cn-northwest-1.console.amazonaws.cn/cloudformation/home?region=cn-northwest-1#/stacks/new?templateURL=https:%2F%2Fsolutions-scheduler.s3.cn-northwest-1.amazonaws.com.cn%2Faws-instance-scheduler%2Fv1.3.0%2Finstance-scheduler.template)

## Deployment resources

[Download deployment guide](https://s3.amazonaws.com/solutions-reference/aws-instance-scheduler/latest/instance-scheduler.pdf)

[AWS Solution Implementation resources](https://aws.amazon.com/solutions/implementations/instance-scheduler/resources/) »

[Contact us](https://aws-china-preview.aka.amazon.com/contact-us/) »

Use the button below to subscribe to solution updates.

[Subscribe to RSS feed](https://solutions-reference.s3.amazonaws.com/aws-instance-scheduler/latest/rss.xml)

Note: To subscribe to RSS updates, you must have an RSS plug-in enabled for the browser you are using.

[Rate this Solution](https://d3j2ena7q16udu.cloudfront.net/rate-this-solution.html)

# Features

## Cross-account instance scheduling
This solution includes a template that creates the AWS Identity and Access Management (IAM) roles necessary to start and stop instances in secondary accounts.

## Scheduler command line interface
This solution includes a command line interface (CLI) that provides commands for configuring schedules and periods. The CLI allows customers to estimate cost savings for a given schedule.

## Automated tagging
The Instance Scheduler can automatically add tags to all instances it starts or stops. The solution also includes macros that allow you to add variable information to the tags.

## Partial automation
Users have the option to implement a partially automated solution by default.
