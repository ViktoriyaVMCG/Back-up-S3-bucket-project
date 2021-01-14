# In that file I set a aws as well default region.
# The region itself I put in the credential file

provider "aws" {
  region = local.region
}

