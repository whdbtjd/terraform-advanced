resource "aws_security_group" "external_lb" {
    name        = "${var.service_name}-${var.vpc_name}-ext"
    description = "${var.service_name} external LB SG"
    vpc_id      = var.target_vpc

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = var.ext_lb_ingress_cidrs
        description = "External service https port"
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = var.ext_lb_ingress_cidrs
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.0.0.0/8"]
        description = "Internal outbound any traffic"
    }

    tags = var.sg_variables.external_lb.tags[var.shard_id]
}

resource "aws_lb_target_group" "external" {
    name                 = "${var.service_name}-${var.shard_id}-ext"
    port                 = var.service_port
    protocol             = "HTTP"
    vpc_id               = var.target_vpc
    slow_start           = var.lb_variables.target_group_slow_start[var.shard_id]
    deregistration_delay = var.lb_variables.target_group_deregistration_delay[var.shard_id]

    health_check {
        interval            = 15
        port                = var.healthcheck_port
        path                = "/"
        timeout             = 3
        healthy_threshold   = 3
        unhealthy_threshold = 2
        matcher             = "200"
    }

    tags = var.lb_variables.external_lb_tg.tags[var.shard_id]
}

resource "aws_lb_listener" "internal_80" {
    load_balancer_arn = aws_lb.external.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_lb_target_group.external.arn
        type             = "forward"
    }
}
