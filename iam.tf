resource "aws_iam_instance_profile" "assort-iam-profile" {
  name = "dev-iam-profile"
  role = "${aws_iam_role.assort_role.name}"
}


resource "aws_iam_role" "assort_role" {
  name = "dev-assort-role"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy" "assort_role_policy" {
  role = "${aws_iam_role.assort_role.id}"
  name = "assort-role-policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::*"
        }
    ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "ec2-ssm-role" {
  role = "${aws_iam_role.assort_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}
