# This file includes local variables, it set variabels for thing that are used in code more than one time or different from site to site
# It makes easy to come here and do changes than go over entire code and find where the variables were used and then changed them one by one.

locals {
  referer_key = "jJB23u002zBZ14gh50gD"
  primary_domain_name = "www.example.com"
  alternate_domain_name = "example.com"
  # Pointing  to the lambda arn in this variable here, since tha lambda function can be used by multiple websites.
  redirect_lambda_arn = "arn:aws:lambda:us-east-1:123456789:function:NonWWWRedirect:1"
  region = "us-east-1"
  cloudfront_ttl = 31536000
  s3_bucket_name = "website-s3-bucket-name"
}
