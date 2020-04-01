variable "prefix" {
}

variable "location" {
  description = "The location in Azure where resources are created"
  default = "westus"
}


variable "admin_username" {
}

// variable "susbcription_id" {
// }

variable "web_node_count" {
}

variable "db_node_count" {
}

variable "bastion_vm_size" {
  description = "Size of the web Node"
}

variable "web_vm_size" {
  description = "Size of the web Node"
}

variable "db_vm_size" {
  description = "Size of the db Nodes"
}

variable "destination_ssh_key_path" {
  description = "Path where ssh keys are copied in the vm. Only /home/<username>/.ssh/authorize_keys is accepted."
}


variable "bastion_inbound_ports" {
  type = list(string)
}
variable "web_inbound_ports" {
  type = list(string)
}

variable "db_inbound_ports" {
  type = list(string)
}

variable "tags" {
  type = map(string)

  default = {
    name = "project_z-app"
    client = "Z_corp"
  }

  description = "Any tags which should be assigned to the resources in this example"
}

