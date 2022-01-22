#!/bin/bash

# Generate Documentation
/var/clone
godoc-static -destination /tmp/docs github.com/parkhub

# Upload documentation to website
aws s3 cp --recursive --exclude docs.zip /tmp/docs s3://parkdoc
aws cloudfront create-invalidation --distribution-id E1WX532CJ5WX9A --paths="/*"
