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

################## Security Group for EC2
resource "aws_security_group" "ec2" {
    name        = "${var.service_name}-${var.vpc_name}"
    description = "${var.service_name} Instance Security Group"
    vpc_id      = var.target_vpc

    ingress {
        from_port = var.service_port
        to_port   = var.service_port
        protocol  = "tcp"

        security_groups = [
            aws_security_group.external_lb.id,
        ]

        description = "Port Open for ${var.service_name}"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Internal outbound traffic"
    }

    tags = {
        Name  = "${var.service_name}-${var.vpc_name}-sg"
        app   = var.service_name
        stack = var.vpc_name
    }
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

resource "aws_lb" "external" {
    name               = "${var.service_name}-${var.shard_id}-ext"
    subnets            = var.public_subnets
    internal           = false

    security_groups = [
        aws_security_group.external_lb.id
    ]

    load_balancer_type = "application"

    tags = var.lb_variables.external_lb.tags[var.shard_id]
}

resource "aws_lb_listener" "external_443" {
    load_balancer_arn = aws_lb.external.arn
    port              = "443"
    protocol          = "HTTPS"

    default_action {
        target_group_arn = aws_lb_target_group.external.arn
        type             = "forward"
    }
}

resource "aws_lb_listener" "external_80" {
    load_balancer_arn = aws_lb.external.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

#### ASG
##### ASG

resource "aws_launch_template" "lt" {
  name_prefix             = "${var.service_name}-${var.vpc_name}-LT"
  image_id                = var.image_id
  instance_type           = var.instance_type
  key_name                = var.key_name

  vpc_security_group_ids  = [aws_security_group.ec2.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.service_name}-${var.vpc_name}-LaunchTemplate"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.private_subnets

  target_group_arns = [aws_lb_target_group.internal.arn]

  tag {
    key                  = "Name"
    value                = "${var.service_name}-${var.vpc_name}-asg"
    propagate_at_launch  = true
  }
}
