resource "aws_launch_configuration" "assort" {
  name_prefix          = "${var.tier}-assort-launchconfig"
  image_id             = "${var.ami}"
  instance_type        = "${var.instance_type}"
  key_name             = "${aws_key_pair.mykey.key_name}"
  security_groups = ["${aws_security_group.assort-sg.id}"]
  user_data            = "${file("userdata.sh")}"
  iam_instance_profile = "${aws_iam_instance_profile.assort-iam-profile.name}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "assort-asg" {
  name                 = "assort-autoscaling"
  vpc_zone_identifier = ["${aws_subnet.private_subnet1.id}" , "${aws_subnet.private_subnet2.id}"]
  launch_configuration = "${aws_launch_configuration.assort.name}"
  min_size             = 2
  max_size             = 4
  health_check_grace_period = 300
  health_check_type = "ELB"
  target_group_arns = ["${aws_alb_target_group.assort-tg.arn}"]
  force_delete = true
  tag {
      key = "Name"
      value = "ng-assort-server"
      propagate_at_launch = true
  }
}