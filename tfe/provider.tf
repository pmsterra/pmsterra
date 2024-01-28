

provider "google" {
  #credentials = file("C:\\Users\\pms00\\Downloads\\k8s-test-393612-c173c9854674.json")
  #project = "155774908440"
  project = "turing-alcove-384403"
  credentials = file("C:\\Users\\pms00\\Downloads\\turing-alcove-384403-d1b7cb3f563a.json")
  region      = "us-central1"  # specify your desired region
 
}


variable "project" {
  type = string
  default = "turing-alcove-384403"
}

# variable "region" {
#   type = string
#   default = "us-central1"
# }

# variable "zone" {
#   type = string
#   default = "us-central1-a"
# }

# variable "vpc_sc_enabled" {
# type = bool
# default = false
  
# }


# module "private_vertex_nb_instances" {
#   source                        = "./"
#   project                       = var.project
#   zone                          = var.zone
#   region                        = var.region
#   notebooks                     = var.notebooks
#   additional_vertex_nb_sa_roles = var.additional_vertex_nb_sa_roles
#   vpc_network_name              = var.vpc_network_name
#   subnet_ip_cidr_range          = var.subnet_ip_cidr_range
#   vpc_sc_enabled                = false
#   additional_fw_rules           = var.additional_fw_rules
#   gcs_bucket_name               = var.gcs_bucket_name
#   gcs_labels                    = var.gcs_labels
# }

