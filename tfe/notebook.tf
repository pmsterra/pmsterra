# resource "google_notebooks_instance" "instance" {
#   name = "notebooks-instance"
#   location = "us-west1-a"
#   machine_type = "e2-medium"
#   project = "155774908440"
#   metadata = {
#     #proxy-mode = ""
#     terraform  = "true"
#     generate-diagnostics-options = "true"
   
#     generate-diagnostics-bucket  = "gs://notebook-pms/"
#     terraform                    = "true"
    
#     serial-port-logging-enable   = "true"
#     #framework                    = "Container: Base"
    
#     proxy-mode                   = "service_account"
#     report-system-health         = "true"
  
#   }
#   container_image {
#     repository = "gcr.io/deeplearning-platform-release/base-cpu"
#     tag = "latest"
#   }
   
 

#   boot_disk_size_gb = "100"

#   boot_disk_type = "PD_SSD"
#   custom_gpu_driver_path = null
#   data_disk_size_gb = "100"
#   data_disk_type = "PD_SSD"
#   #disk_encryption = "CMEK"
#   install_gpu_driver = false
# instance_owners =  ["pmsgcp2301@gmail.com"] 
# labels = {
#     testlabel = "test"
#   }
#    #kms_key = ""
#   #no_proxy_access = "false"
#   no_public_ip = "true"  
#   no_remove_data_disk = null
#   service_account = "notebook-sa@k8s-test-393612.iam.gserviceaccount.com"
#   service_account_scopes = null
#   # shielded_instance_config {
#   #   enable_integrity_monitoring = "false"
#   #   enable_secure_boot = "false"
#   #   enable_vtpm = "false"
#   # }

#   shielded_instance_config {
#     enable_integrity_monitoring = "true"
#     enable_secure_boot          = "true"
#     enable_vtpm                 = "true"
#   }
  
  
  
#   lifecycle {
#     ignore_changes = [ disk_encryption ,kms_key]
#   }
  
#   tags = null

#  }


# resource "google_notebooks_instance" "instance" {
#   name = "notebooks-instance1"
#   location = "us-central1-a"
#   machine_type = "e2-medium"
#   #project = "155774908440"
#   project = "turing-alcove-384403"
#   metadata = {
#     #proxy-mode = ""
#     #terraform  = "true"
#     generate-diagnostics-options = "true"
   
#     generate-diagnostics-bucket  = "gs://notebook-pms/"
    
    
#     serial-port-logging-enable   = "true"
#     #framework                    = "Container: Base"
    
#     #proxy-mode                   = "service_account"
#     report-system-health         = "true"
  
#   }
#   # container_image {
#   #   repository = "gcr.io/deeplearning-platform-release/base-cpu"
#   #   tag = "latest"
#   # }
#    vm_image {
#     project      = "deeplearning-platform-release"
#     image_family = "tf-ent-2-9-cu113-notebooks"
#   }
 

#   # boot_disk_size_gb = "100"

#   # boot_disk_type = "PD_SSD"
#   # custom_gpu_driver_path = null
#   # data_disk_size_gb = "100"
#   # data_disk_type = "PD_SSD"
#   # #disk_encryption = "CMEK"
#   # install_gpu_driver = false
# instance_owners =  ["pmsgcp2301@gmail.com"] 
# labels = {
#     testlabel = "test"
#   }
#    #kms_key = ""
#   #no_proxy_access = "false"
#   no_public_ip = "true"  
#   #
#   #service_account = "notebook-sa@k8s-test-393612.iam.gserviceaccount.com"
#   service_account = "notebook-sa@turing-alcove-384403.iam.gserviceaccount.com"
#   #service_account_scopes = null
#   # shielded_instance_config {
#   #   enable_integrity_monitoring = "false"
#   #   enable_secure_boot = "false"
#   #   enable_vtpm = "false"
#   # }

  
  
#   tags = null

#  }





























