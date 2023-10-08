let
  ben = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPKXzCnfnqDiCM48cg90DfIraKObkgjj5E42OZaCsdcI";
  users = [ ben ];
in
{
  "password.age".publicKeys = [ ben ];
}
