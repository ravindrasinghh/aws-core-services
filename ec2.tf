resource "aws_instance" "ec2" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = aws_key_pair.demo_key_1.key_name
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  iam_instance_profile   = "${aws_iam_instance_profile.ec2_iam_profile.name}"
  user_data              = "${file("userdata/userdata.sh")}"
  subnet_id              = "${aws_subnet.pub_subnet1.id}"
  tags = {
    Name = "${var.tier}-assort"
  }
}
resource "aws_eip" "ec2" {
  instance = "${aws_instance.ec2.id}"
  vpc      = true
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.ec2.id}"
  allocation_id = "${aws_eip.ec2.id}"
}
resource "aws_security_group" "ec2_sg" {
  name        = "${var.tier}-sg"
  description = "Security group for ec2"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "ec2_iam_profile" {
  name = "ec2_iam_profile"
  role = "${aws_iam_role.ec2_ssm_role.name}"
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_policy" {
  role       = "${aws_iam_role.ec2_ssm_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

output "out_EC2_IP" {
  value = "${aws_instance.ec2.public_ip}"
}
