variable "lb_variables" {
  default = {

    target_group_slow_start = {
      whdbtjd_1 = 0
      whdbtjd_2 = 0
      whdbtjd_3 = 0
    }

    target_group_deregistration_delay = {
      whdbtjd_1 = 0
      whdbtjd_2 = 60
      whdbtjd_3 = 60
    }

    internal_lb = {
      tags = {}
    }

    internal_lb_tg = {
      tags = {}
    }

    external_lb = {
      tags = {
        whdbtjd_1 = {
          Name    = "hello-whdbtd_1-external-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtd_1"
        },

        whdbtjd_2 = {
          Name    = "hello-whdbtjd_2-external-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_2"
        },

        whdbtjd_3 = {
          Name    = "hello-whdbtjd_3-external-lb"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd_3"
        }
      }
    }

    external_lb_tg = {
      tags = {
        whdbtjd_1 = {
          Name    = "hello-whdbtd_1-external-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtd_1"
        },

        whdbtjd_2 = {
          Name    = "hello-whdbtjd_2-external-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_2"
        },

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
