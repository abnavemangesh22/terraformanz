


module "mypc" {
  
  source = "./vm-module" 
  mymachine_name = "sample_machine"
  mymachine_type = "e2-medium"

}