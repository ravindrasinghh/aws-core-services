resource "aws_security_group" "assort-sg" {
  vpc_id = "${aws_vpc.vpc.id}"
  name = "${terraform.workspace}-sg"
  description = "security group for my instance"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["10.222.112.0/23"]
  } 
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
  }  
  
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"] 

  }


   
}    
resource "aws_security_group" "elb-securitygroup" {
  vpc_id = "${aws_vpc.vpc.id}"
  name = "elb"
  description = "security group for load balancer"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
}