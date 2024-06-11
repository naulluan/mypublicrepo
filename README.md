# mypublicrepo
inputs = merge(
  local.common_vars.inputs,
  {
    elb_name           = "nlb"
    load_balancer_type = "network"
    internal           = true
    http_tcp_listeners = [
      {
        port               = 80
        protocol           = "TCP"
        target_group_index = 0
      },
      {
        port               = 443
        protocol           = "TCP"
        target_group_index = 1
      }

    ]
    target_groups = [
      {
        name             = "msbweb-nlb-to-alb-http"
        backend_protocol = "TCP"
        backend_port     = 80
        target_type      = "alb"
        vpc_id           = dependency.vpc.outputs.vpc_id
      },
      {
        name             = "msbweb-nlb-to-alb-https"
        backend_protocol = "TCP"
        backend_port     = 443
        target_type      = "alb"
        vpc_id           = dependency.vpc.outputs.vpc_id
      }
    ]
    vpc_id    = dependency.vpc.outputs.vpc_id
    subnets   = dependency.vpc.outputs.private_subnets
    create_s3 = false
  }
)
