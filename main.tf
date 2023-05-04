provider "kubernetes" {
  config_path = var.kubeconfig
}

resource "kubernetes_manifest" "vaultserver" {
  manifest = {
    "apiVersion" = "kubevault.com/v1alpha2"
    "kind"       = "VaultServer"
    "metadata" = {
      "name"      = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "allowedSecretEngines" = {
        "namespaces" = {
          "from" = var.allowed_secret_engines.namespaces_from
        }
        "secretEngines" = var.allowed_secret_engines.secret_engines
      }
      "backend" = {
        "raft" = {
          "storage" = {
            "resources" = {
              "requests" = {
                "storage" = var.raft.storage
              }
            }
            "storageClassName" = var.raft.storage_class
          }
        }
      }
      "replicas"          = var.replicas
      "terminationPolicy" = var.termination_policy
      "unsealer" = {
        "mode" = {
          "kubernetesSecret" = {
            "secretName" = "vault-keys"
          }
        }
        "secretShares"    = 5
        "secretThreshold" = 3
      }
      "version" = var.vault_server_version
    }
  }

  wait_for = {
    fields = {
        "status.phase" = "Ready",
    }
  }
}
