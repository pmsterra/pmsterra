project              = "k8s-test-393612"
zone                 = "us-west1-a"
region               = "us-west1"
network_name         = "example-vpc"
subnetwork_name      = "example-subnet"
vpc_network_name     = "example-vpc"
subnet_ip_cidr_range = "10.1.0.0/24"
gcs_bucket_name      = "pms-bucket-name"
gcs_labels           = { "foo" : "bar" }


notebooks = {
  "example-user-managed-instance" : {
    "labels" : { "foo" : "bar" },
    "instance_owner" : "pmsgcp2301@gmail.com"
    "metadata" : {}
    "type" : "user-managed-notebook",
  }
  # "example-google-managed-instance" : {
  #   "labels" : { "foo" : "bar" },
  #   "instance_owner" : "pmsgcp2301@gmail.com"
  #   "metadata" : {}
  #   "access_type" : "SERVICE_ACCOUNT"
  #   "type" : "google-managed-notebook"
  # }
}

additional_vertex_nb_sa_roles = [
  "roles/dataproc.editor",
  "roles/dataproc.hubAgent"
]

additional_fw_rules = [{
  name                    = "egress-allow-example-google"
  description             = "Allow egress example"
  direction               = "EGRESS"
  priority                = 65534
  ranges                  = ["142.250.178.14/32","74.125.197.0/24","74.125.199.0/24"] # google.com
  source_tags             = null
  source_service_accounts = null
  target_tags             = null
  target_service_accounts = null
  allow = [{
    protocol = "tcp"
    ports    = ["443"]
  }]
  deny = []
  log_config = {
    metadata = "INCLUDE_ALL_METADATA"
  }
}]
