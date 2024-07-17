    cluster_addons = {
      coredns = {
        addon_version               = "v1.10.1-eksbuild.4"
        resolve_conflicts_on_update = "OVERWRITE"
        resolve_conflicts_on_create = "OVERWRITE"
        configuration_values = jsonencode({
          replicaCount = 2
          nodeSelector = {
            type = "infra"
          }
          tolerations = [
            {
              operator = "Equal"
              key      = "dedicated"
              value    = "infraGroup"
              effect   = "NoSchedule"
            }
          ]
        })
      }
      kube-proxy = {
        addon_version               = "v1.27.4-eksbuild.2"
        resolve_conflicts_on_update = "OVERWRITE"
        resolve_conflicts_on_create = "OVERWRITE"
      }
      vpc-cni = {
        addon_version               = "v1.15.0-eksbuild.2"
        resolve_conflicts_on_update = "OVERWRITE"
        resolve_conflicts_on_create = "OVERWRITE"
        configuration_values = jsonencode({
          env = {
            ENABLE_PREFIX_DELEGATION = "true"
            WARM_PREFIX_TARGET       = "1"
          }
        })
      }
    }
