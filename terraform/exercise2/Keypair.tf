resource "aws_key_pair" "dove_key" {
  key_name   = "dove-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCcimMr9CFMd4CS/WrjqjLfqW6etmev2alSsH6Q91ilLdzkv6jqs7nwNnnH6K8C6y2pHoTns2z+uNAMElEJC3WrmDyg/1xzgSWO5XwPvBwBwgHEd7HADV41gSch7WUU6vCWddC1OEjlqnvBDmKL2Tujdla+MUwL4AFNNEqraK8dWfFybh//brOXRBmTWeo74iDp8ENHBTEXURTT9o8lScfUqYyrU1pu8FC4/f9R6kJDhtmfSoWxHnP9mTxNl5QDAI8wQD5oWL+2nxPBhr/e/jF9pvMQH1zL/RbUqpPMVISp4g0V2Qpq+7oF1RigkfbKRiVY88cIsSoMo9dAyCV/+I+lKuJ/casboVQYB2+upzFEGdkuCZeHLevaNS+SwAhnB2sXQCPHX3eMoF9v/okbagrh6YSLPMVIKh02cRbXBACs1q1D9WlV3hUibgYNzqkhSBqtOccId8SQPtBxihf9GPwucwIO2Jsdk7YACT9FZSfHWhuIxuIenWpHq5+GtKb1i6s= jacegonzales@jacegonzales-IdeaPad-Gaming-3-15ARH7"
}

#ssh-keygen to get public key, key_name can be changed