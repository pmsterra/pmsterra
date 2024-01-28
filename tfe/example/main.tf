module "private_vertex_nb_instances" {
  source                        = "../"
  project                       = "turing-alcove-384403"
  zone                          = "us-west1-b"
  region                        = "us-west1"  
  notebooks                     = var.notebooks
  additional_vertex_nb_sa_roles = var.additional_vertex_nb_sa_roles
  vpc_network_name              = var.vpc_network_name
  subnet_ip_cidr_range          = var.subnet_ip_cidr_range
  vpc_sc_enabled                = false
  additional_fw_rules           = var.additional_fw_rules
  gcs_bucket_name               = var.gcs_bucket_name
  gcs_labels                    = var.gcs_labels
}

provider "google" {
  #credentials = file("C:\\Users\\pms00\\Downloads\\k8s-test-393612-c173c9854674.json")
  #project = "155774908440"
  project = "turing-alcove-384403"
  credentials = file("C:\\Users\\pms00\\Downloads\\turing-alcove-384403-d1b7cb3f563a.json")
  region      = "us-central1"  # specify your desired region
 
}












# # module.private_vertex_nb_instances.google_notebooks_instance.notebook_instance["example-user-managed-instance"] will be created
#   + resource "google_notebooks_instance" "notebook_instance" {
#       + boot_disk_size_gb   = 100
#       + boot_disk_type      = "PD_STANDARD"
#       + create_time         = (known after apply)
#       + data_disk_size_gb   = 100
#       + effective_labels    = (known after apply)
#       + id                  = (known after apply)
#       + install_gpu_driver  = false
#       + instance_owners     = [
#           + "pmsgcp2301@gmail.com",
#         ]
#       + location            = "us-west1-b"
#       + machine_type        = "n1-standard-4"
#       + metadata            = {
#           + "notebook-disable-downloads" = "true"
#           + "notebook-disable-nbconvert" = "true"
#           + "notebook-disable-root"      = "true"
#           + "report-system-health"       = "true"
#           + "terraform"                  = "true"
#         }
#       + name                = "example-user-managed-instance"
#       + network             = "projects/turing-alcove-384403/global/networks/example-vpc"
#       + no_public_ip        = true
#       + no_remove_data_disk = true
#       + project             = "turing-alcove-384403"
#       + proxy_uri           = (known after apply)
#       + service_account     = "vertex-nb-sa@turing-alcove-384403.iam.gserviceaccount.com"
#       + state               = (known after apply)
#       + subnet              = "projects/turing-alcove-384403/regions/us-west1/subnetworks/example-vpc-vertex-subnet"
#       + terraform_labels    = (known after apply)
#       + update_time         = (known after apply)

#       + container_image {
#           + repository = "gcr.io/deeplearning-platform-release/base-cpu"
#           + tag        = "latest"
#         }
#     }


