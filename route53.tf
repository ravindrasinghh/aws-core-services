data "aws_route53_zone" "zone" {
 name = "assort.com"
}

resource "aws_route53_record" "assort_record" {
    zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name = "dev.${data.aws_route53_zone.zone.name}"
 type = "A"

  alias {
      zone_id = "${aws_lb.assort-alb-alb.zone_id}"
      name = "${aws_lb.assort-alb-alb.dns_name}"
      evaluate_target_health = true
  }
}
