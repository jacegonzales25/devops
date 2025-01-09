terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "path/to/my/state/file/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table"  # Optional, for state locking
    encrypt        = true                    # Enable server-side encryption
  }
}
