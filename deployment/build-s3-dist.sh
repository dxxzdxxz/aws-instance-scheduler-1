#!/bin/bash
#
# This assumes all of the OS-level configuration has been completed and git repo has already been cloned
#
# This script should be run from the repo's deployment directory
# cd deployment
# ./build-s3-dist.sh source-bucket-base-name trademarked-solution-name version-code aws-region-code
#
# Parameters:
#  - template-bucket-name: Name for S3 bucket location where the template will be located in.
#
#  - source-bucket-base-name: Name for the S3 bucket location where the template will source the Lambda
#    code from. The template will append '-[region_name]' to this bucket name.
#    For example: ./build-s3-dist.sh solutions-reference solutions my-solution v1.0.0
#    The template will then expect the source code to be located in the solutions-[region_name] bucket
#
#  - solution-name: name of the solution for consistency
#
#  - version-code: version of the solution
#

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
    echo "Please provide the templete final store bucket name, base source bucket name, trademark approved solution name and version where the lambda code will eventually reside."
    echo "For example: ./build-s3-dist.sh template-bucket-name source-bucket-base-name trademarked-solution-name v1.0.0"
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
cd ../source/code

newbucket=$1
base_bucket=$2
case $SHELL in
*/zsh)
    region=${newbucket##$base_bucket-}
    echo "region ${region}" 
    ;;
*/bash)
    region_index=$(expr match "${newbucket}" "${base_bucket}")
    echo "region_index ${region_index}"
    region=${newbucket:$region_index+1}
    echo "region ${region}"
    ;;
*/sh)
    region_index=$(expr match "${newbucket}" "${base_bucket}")
    echo "region_index ${region_index}"
    region=${newbucket:$region_index+1}
    echo "region ${region}"
    ;;
*)
    echo "non-supported shell"
    exit 1
esac

echo "make final_bucket=$1 bucket=$2 solution=$3 version=$4 region=$region"
make final_bucket=$1 bucket=$2 solution=$3 version=$4 region=$region
echo "Completed building distribution"