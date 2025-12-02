variable "sg_variables" {
  default = {

    #######################
    # EC2 SG Tag Values
    #######################
    ec2 = {
      tags = {
        whdbtjd-1 = {
          Name    = "hello-whdbtjd-1-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-1"
        }

        whdbtjd-2 = {
          Name    = "hello-whdbtjd-2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-2"
        }

        whdbtjd-3 = {
          Name    = "hello-whdbtjd-3-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd-3"
        }
      }
    }

    ###########################
    # External LB SG Tag Values
    ###########################
    external_lb = {
      tags = {
        whdbtjd-1 = {
          Name    = "hello-whdbtjd-1-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-1"
        }

        whdbtjd-2 = {
          Name    = "hello-whdbtjd-2-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-2"
        }

        whdbtjd-3 = {
          Name    = "hello-whdbtjd-3-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd-3"
        }
      }
    }

    ###########################
    # Internal LB SG Tag Values
    ###########################
    internal_lb = {
      tags = {
        whdbtjd-1 = {
          Name    = "hello-whdbtjd-1-internal-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-1"
        }

        whdbtjd-2 = {
          Name    = "hello-whdbtjd-2-internal-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd-2"
        }

        whdbtjd-3 = {
          Name    = "hello-whdbtjd-3-internal-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd-3"
        }
      }
    }

  }
}
