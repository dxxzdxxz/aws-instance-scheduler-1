#!/bin/bash
#
# This assumes all of the OS-level configuration has been completed and git repo has already been cloned
#
# This script should be run from the repo's deployment directory
# cd deployment
# ./build-s3-dist.sh source-bucket-base-name trademarked-solution-name version-code aws-region-code
#
# Parameters:
#  - source-bucket-base-name: Name for the S3 bucket location where the template will source the Lambda
#    code from.
#    For example: ./build-s3-dist.sh solutions my-solution v1.0.0 cn-northwest-1
#    The template will then expect the source code to be located in the solutions bucket
#
#  - trademarked-solution-name: name of the solution for consistency
#
#  - version-code: version of the solution
#
#  - aws-region-code: the aws region to host the solution

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
    echo "Please provide the base source bucket name, trademark approved solution name and version where the lambda code will eventually reside."
    echo "For example: ./build-s3-dist.sh solutions trademarked-solution-name v1.0.0 cn-northwest-1"
    exit 1
fi

# Get reference for all important folders
template_dir="$PWD"
template_dist_dir="$template_dir/global-s3-assets"
build_dist_dir="$template_dir/regional-s3-assets"
source_dir="$template_dir/../source"

echo "------------------------------------------------------------------------------"
echo "[Init] Clean old dist, node_modules and bower_components folders"
echo "------------------------------------------------------------------------------"
echo "rm -rf $template_dist_dir"
rm -rf $template_dist_dir
echo "mkdir -p $template_dist_dir"
mkdir -p $template_dist_dir
echo "rm -rf $build_dist_dir"
rm -rf $build_dist_dir
echo "mkdir -p $build_dist_dir"
mkdir -p $build_dist_dir

echo "------------------------------------------------------------------------------"
echo "[Packing] Templates"
echo "------------------------------------------------------------------------------"
echo "cp $template_dir/*.template $template_dist_dir/"
cp $template_dir/*.template $template_dist_dir/
# echo "copy yaml templates and rename"
# cp $template_dir/*.yaml $template_dist_dir/
# cd $template_dist_dir
# # Rename all *.yaml to *.template
# for f in *.yaml; do
#     mv -- "$f" "${f%.yaml}.template"
# done

echo "------------------------------------------------------------------------------"
echo "Generate Cloudformation template and related resources by Makefile"
echo "------------------------------------------------------------------------------"
echo "make bucket=$1 solution=$2 version=$3 region=$4"
make bucket=$1 solution=$2 version=$3 region=$4
echo "Completed building distribution"