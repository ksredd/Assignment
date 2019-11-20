
module "network" {
  source = "./module/networking"
  vpc_cidr = "129.10.0.0/16"
  key_pair_name= ""
  
}


