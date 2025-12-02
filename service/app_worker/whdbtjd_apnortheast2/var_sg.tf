variable "sg_variables" {
  default = {

    ec2 = {
      tags = {
        whdbtjd_1 = {
          Name    = "hello-whdbtjd_1-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_1"
        }

        whdbtjd_2 = {
          Name    = "hello-whdbtjd_2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_2"
        }

        whdbtjd_3 = {
          Name    = "hello-whdbtjd_3-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd_3"
        }
      }
    }

    external_lb = {
      tags = {
        whdbtjd_1 = {
          Name    = "hello-whdbtjd_1-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_1"
        }

        whdbtjd_2 = {
          Name    = "hello-whdbtjd_2-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "whdbtjd_2"
        }

        whdbtjd_3 = {
          Name    = "hello-whdbtjd_3-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "whdbtjd_3"
        }
      }
    }

  }
}
