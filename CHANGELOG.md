# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0] - 2020-04-25
### Added
- The repo forked from https://github.com/awslabs/aws-instance-scheduler and made update for china region based on v1.3.0 version. 
- Update the arn with arn:${AWS::Partition} for cloudformation
- Make solution can be build by build-s3-dist.sh and upload by deploy-dist.sh