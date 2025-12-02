variable "lb_variables" {
  default = {

    # Target Group slow start (for all shards)
    target_group_slow_start = {
      whdbtjd-1 = 0
      whdbtjd-2 = 0
      whdbtjd-3 = 0
    }

    # Target Group deregistration delay (for all shards)
    target_group_deregistration_delay = {
      whdbtjd-1 = 0
      whdbtjd-2 = 60
      whdbtjd-3 = 60
    }

    ###########################
    # Internal LB Tag Values
    ###########################
    internal_lb = {
      tags = {
        whdbtjd-1 = {
          Name    = "hello-whdbtjd-1-internal-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-1"
        }

        whdbtjd-2 = {
          Name    = "hello-whdbtjd-2-internal-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-2"
        }

        whdbtjd-3 = {
          Name    = "hello-whdbtjd-3-internal-lb"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd-3"
        }
      }
    }

    ###############################
    # Internal LB Target Group Tags
    ###############################
    internal_lb_tg = {
      tags = {
        whdbtjd-1 = {
          Name    = "hello-whdbtjd-1-internal-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-1"
        }

        whdbtjd-2 = {
          Name    = "hello-whdbtjd-2-internal-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-2"
        }

        whdbtjd-3 = {
          Name    = "hello-whdbtjd-3-internal-tg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd-3"
        }
      }
    }

    ###########################
    # External LB Values
    ###########################
    external_lb = {
      tags = {
        whdbtjd-1 = {
          Name    = "hello-whdbtd-1-external-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtd-1"
        }

        whdbtjd-2 = {
          Name    = "hello-whdbtjd-2-external-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-2"
        }

        whdbtjd-3 = {
          Name    = "hello-whdbtjd-3-external-lb"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd-3"
        }
      }
    }

    ###################################
    # External LB Target Group Values
    ###################################
    external_lb_tg = {
      tags = {
        whdbtjd-1 = {
          Name    = "hello-whdbtd-1-external-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtd-1"
        }

        whdbtjd-2 = {
          Name    = "hello-whdbtjd-2-external-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-2"
        }

        whdbtjd-3 = {
          Name    = "hello-whdbtjd-3-external-tg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd-3"
        }
      }
    }

  }
}
