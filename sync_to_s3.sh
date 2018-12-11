#!/bin/bash

set -eu -o pipefail
set -x

bucket_prefix=jbm-test

ls -d */ | sort -R | while read dir; do
    sanitized_dir=$(echo $dir | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | tr ',' '-')
    bucket_name="s3://$bucket_prefix-$sanitized_dir"
    echo "$dir -> $bucket_name"
    aws s3 mb "$bucket_name"
    aws s3 sync "$dir" "$bucket_name"
done
