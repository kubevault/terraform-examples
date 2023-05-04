variable "kubeconfig" {
  default = "~/.kube/config"
}

variable "name" {
  type        = string
  default     = "vault"
  description = "name of vault server instance"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "namespace to deploy Vault Server, must already exist"
}

variable "replicas" {
  type        = number
  default     = 3
  description = "number of replicase for the Vault Server"
}

variable "vault_server_version" {
  type        = string
  default     = "1.12.1"
  description = "name of the vault version CR to use"
}

variable "termination_policy" {
  type        = string
  default     = "WipeOut"
  description = "termination policy for the vaut server"
}

variable "allowed_secret_engines" {
  type = object({
    namespaces_from = string
    secret_engines  = list(string)
  })
  default = {
    namespaces_from = "All"
    secret_engines  = ["gcp"]
  }
  description = "allowed secret engines parameters"
}

variable "raft" {
  type = object({
    storage       = string
    storage_class = string
  })
  default = {
    storage       = "1Gi"
    storage_class = "standard"
  }
  description = "raft storage parameters"
}
