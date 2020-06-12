resource "aws_lb" "assort-alb" {
  name               = "assort"
  internal           = false
  security_groups    = ["${aws_security_group.elb-securitygroup.id}"]
  subnets            = ["${aws_subnet.pub_subnet1.id}" , "${aws_subnet.pub_subnet2.id}"]
  enable_deletion_protection = false
  enable_http2 = "false"
  tags = {
    Environment = "dev"
  }
}
resource "aws_lb_listener" "assort-alb" {
  load_balancer_arn = "${aws_lb.assort-alb.arn}"
  port              = "80"
  protocol          = "HTTP"
    default_action {
      
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.assort-tg.arn}"
  }
}

resource "aws_alb_target_group" "assort-tg" {
	name	= "${terraform.workspace}-assort"
	vpc_id	= "${aws_vpc.vpc.id}"
	port	= "80"
	protocol	= "HTTP"
	health_check {
    protocol = "HTTP"
    path = "/index.html"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 5
    timeout = 4
    matcher = "200-308"
  }
  lifecycle {
    create_before_destroy = true
  }
}
