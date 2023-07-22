# VPC作成
resource "aws_vpc" "terraform_vpc" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  tags = {
    Name    = "terraform-vpc"
  }
}

# IGW作成とアタッチ（vpc_idを指定すると自動的にそのVPCにアタッチしてくれる）
resource "aws_internet_gateway" "terraform_igw" {
    vpc_id = aws_vpc.terraform_vpc.id
    tags = {
        Name = "terraform-igw"
    }
}

# パブリックサブネットの作成
resource "aws_subnet" "terraform_public_subnet_1a" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  tags = {
    Name    = "terraform-public-subnet-1a"
  }
}
resource "aws_subnet" "terraform_public_subnet_1c" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  tags = {
    Name    = "terraform-public-subnet-1c"
  }
}

# プライベートサブネットの作成
resource "aws_subnet" "terraform_private_subnet_1a" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.128.0/20"
  map_public_ip_on_launch = false
  tags = {
    Name    = "terraform-private-subnet-1a"
  }
}
resource "aws_subnet" "terraform_private_subnet_1c" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.144.0/20"
  map_public_ip_on_launch = false
  tags = {
    Name    = "terraform-private-subnet-1c"
  }
}

# パブリックサブネットのルートテーブル作成と関連付け 
resource "aws_route_table" "terraform_public_route_table" {
    vpc_id = aws_vpc.terraform_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform_igw.id
    }
    tags = {
        Name = "terraform-public-route-table"
    }
}
resource "aws_route_table_association" "terraform_public_subnet1a_route_tabel_association" {
    subnet_id      = aws_subnet.terraform_public_subnet_1a.id
    route_table_id = aws_route_table.terraform_public_route_table.id
}
resource "aws_route_table_association" "terraform_public_subnet1c_route_tabel_association" {
    subnet_id      = aws_subnet.terraform_public_subnet_1c.id
    route_table_id = aws_route_table.terraform_public_route_table.id
}

# プライベートサブネットのルートテーブル作成と関連付け 
resource "aws_route_table" "terraform_private_route_table" {
    vpc_id = aws_vpc.terraform_vpc.id
    tags = {
        Name = "terraform-private-route-table"
    }
}
resource "aws_route_table_association" "private_subnet1a_route_table_association" {
  route_table_id = aws_route_table.terraform_private_route_table.id
  subnet_id      = aws_subnet.terraform_private_subnet_1a.id
}
resource "aws_route_table_association" "private_subnet1c_route_table_association" {
  route_table_id = aws_route_table.terraform_private_route_table.id
  subnet_id      = aws_subnet.terraform_private_subnet_1c.id
}
