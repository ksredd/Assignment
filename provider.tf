
provider "aws" {
  region = "eu-west-2"
   #shared_credentials_file = "/Users/tf_user/.aws/creds"
    shared_credentials_file = "${var.credentialsfile}"

}
