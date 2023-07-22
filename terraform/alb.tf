# ALBの作成
resource "aws_lb" "terraform_alb" {
        name               = "terraform-alb"
    load_balancer_type = "application"
    internal           = false
    ip_address_type    = "ipv4"
    security_groups    = [aws_security_group.terraform_alb_sg.id]
    subnets            = [aws_subnet.terraform_public_subnet_1a.id, aws_subnet.terraform_public_subnet_1c.id]
    tags = {
        Name = "terraform-alb"
    }
}

# ALBセキュリティーグループの作成
resource "aws_security_group" "terraform_alb_sg" {
    name   = "terraform-alb-sg"
    vpc_id = aws_vpc.terraform_vpc.id
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}

# ターゲットグループの作成
resource "aws_lb_target_group" "terraform_alb_tg" {
    name         = "terraform-alb-tg"
    vpc_id       = aws_vpc.terraform_vpc.id
    target_type  = "instance"
    protocol     = "HTTP"
    port         = 80
    health_check {
        protocol = "HTTP"
        path     = "/"
    }
    tags = {
        Name = "terraform-alb-tg"
    }
}

# EC2にターゲットグループをアタッチ
resource "aws_lb_target_group_attachment" "terraform-target-group-attach-ec2" {
    target_group_arn = aws_lb_target_group.terraform_alb_tg.arn
    target_id        = aws_instance.terraform_ec2.id
}

# リスナー設定
resource "aws_lb_listener" "terraform_alb_listener" {
    load_balancer_arn = aws_lb.terraform_alb.arn
    default_action {
        target_group_arn = aws_lb_target_group.terraform_alb_tg.arn
        type             = "forward"
    }
    port              = "80"
    protocol          = "HTTP"
}