variable "lb_variables" {
  default = {

    # Target Group slow start (for all shards)
    target_group_slow_start = {
      whdbtjd_1 = 0
      whdbtjd_2 = 0
      whdbtjd_3 = 0
    }

    # Target Group deregistration delay (for all shards)
    target_group_deregistration_delay = {
      whdbtjd_1 = 0
      whdbtjd_2 = 60
      whdbtjd_3 = 60
    }

    ###########################
    # Internal LB Tag Values
    ###########################
    internal_lb = {
      tags = {
        whdbtjd_1 = {
          Name    = "hello-whdbtjd_1-internal-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_1"
        }

        whdbtjd_2 = {
          Name    = "hello-whdbtjd_2-internal-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_2"
        }

        whdbtjd_3 = {
          Name    = "hello-whdbtjd_3-internal-lb"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd_3"
        }
      }
    }

    ###############################
    # Internal LB Target Group Tags
    ###############################
    internal_lb_tg = {
      tags = {
        whdbtjd_1 = {
          Name    = "hello-whdbtjd_1-internal-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_1"
        }

        whdbtjd_2 = {
          Name    = "hello-whdbtjd_2-internal-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_2"
        }

        whdbtjd_3 = {
          Name    = "hello-whdbtjd_3-internal-tg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd_3"
        }
      }
    }

    ###########################
    # External LB Values
    ###########################
    external_lb = {
      tags = {
        whdbtjd_1 = {
          Name    = "hello-whdbtd_1-external-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtd_1"
        }

        whdbtjd_2 = {
          Name    = "hello-whdbtjd_2-external-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_2"
        }

        whdbtjd_3 = {
          Name    = "hello-whdbtjd_3-external-lb"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd_3"
        }
      }
    }

    ###################################
    # External LB Target Group Values
    ###################################
    external_lb_tg = {
      tags = {
        whdbtjd_1 = {
          Name    = "hello-whdbtd_1-external-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtd_1"
        }

        whdbtjd_2 = {
          Name    = "hello-whdbtjd_2-external-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_2"
        }

        whdbtjd_3 = {
          Name    = "hello-whdbtjd_3-external-tg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd_3"
        }
      }
    }

  }
}
