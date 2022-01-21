# Parkdoc Update Action

Generates all documentation for parkhub repos with topic `golib`. Uploads them to the parkdoc s3 folder
and invalidates cache.

To add this to your repo you will need 3 secrets, you aws credentials and a github access token
 - AWS_ACCESS_KEY_ID
 - AWS_SECRET_ACCESS_KEY
 - TOKEN