variable "instance_owner" {
  description = "The email address of the instance owner."
  type        = string

  validation {
    condition = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.instance_owner)) && !can(regex("@.*\\.iam\\.gserviceaccount\\.com$", var.instance_owner))
    error_message = "The 'instance_owner' must be a valid user email address and cannot be a service account email address."
  }
}
