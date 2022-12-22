data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = data.aws_vpc.default_vpc.id
  tags = {
    Name = "internet_gateway"
  }

}

resource "aws_route_table" "public_route_table" {
  vpc_id = data.aws_vpc.default_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id

  }
}