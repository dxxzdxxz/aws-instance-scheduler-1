#!/bin/bash
#
# This assumes all of the OS-level configuration has been completed and git repo has already been cloned
#
# This script should be run from the repo's deployment directory
# cd deployment
# ./deploy-dist.sh source-bucket-base-name trademarked-solution-name version-code  aws-region-code
#
# Parameters:
#  - source-bucket-base-name: Name for the S3 bucket location where the template will source the Lambda
#    code from. The template will append '-[region_name]' to this bucket name.
#    For example: ./deploy-dist.sh solutions my-solution v1.0.0 cn-northwest-1
#    The template will then expect the source code to be located in the solutions-[region_name] bucket
#
#  - trademarked-solution-name: name of the solution for consistency
#
#  - version-code: version of the solution
#
#  - aws-region-code: the aws region to host the solution

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
    echo "Please provide the base source bucket name, trademark approved solution name and version where the lambda code will eventually reside."
    echo "For example: ./deploy-dist.sh solutions trademarked-solution-name v1.0.0 cn-northwest-1"
    exit 1
fi

echo "------------------------------------------------------------------------------"
echo "Upload Cloudformation template and related resources to S3"
echo "------------------------------------------------------------------------------"
echo "make deploy bucket=$1 solution=$2 version=$3 region=$4"
make deploy bucket=$1 solution=$2 version=$3 region=$4
echo "Completed upload distribution"