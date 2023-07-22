# RDSの作成
resource "aws_db_instance" "terraform_rds"{    
    identifier              = "terraform-rds"
    engine                  = "mysql"
    engine_version          = "8.0.32"
    multi_az                = false
    username                = "admin"
    password                = "${var.mysql_master_user_pass}"
    instance_class          = "db.t2.micro"
    storage_type            = "gp2"
    allocated_storage       = 20
    db_subnet_group_name    = aws_db_subnet_group.terraform_rds_subnet_group.name
    publicly_accessible     = false
    vpc_security_group_ids  = [aws_security_group.terraform-rds-sg.id]
    availability_zone       = "ap-northeast-1a"
    port                    = 3306
    backup_retention_period = 0
    skip_final_snapshot  = true
    auto_minor_version_upgrade = false
    tags = {
        Name = "terraform-rds"
    }
}

# RDS Security Groupの作成
resource "aws_security_group" "terraform-rds-sg" {
    name        = "terraform-rds-sg"
    vpc_id      = aws_vpc.terraform_vpc.id
    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [aws_security_group.terraform_ec2_sg.id]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}

# RDS Subnet Groupの作成
resource "aws_db_subnet_group" "terraform_rds_subnet_group" {
    name        = "terraform-subnet-group"
    subnet_ids  = [aws_subnet.terraform_private_subnet_1a.id, aws_subnet.terraform_private_subnet_1c.id]
    tags = {
        Name = "terraform-rds-subnet-group"
    }
}
