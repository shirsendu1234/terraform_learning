data "aws_route53_zone" "myapp_private_hosted_zone" {
 vpc_id       = "${var.myapp_vpc.id}"
 name         = "${var.private_hosted_zone_name}"
 private_zone = true
}

resource "aws_eip" "myapp_eip" {
 instance = "${aws_instance.myapp_ec2_instance.id}"
 vpc      = true
}

resource "aws_route53_record" "myapp_hosted_zone_entry" {
 zone_id = "${data.aws_route53_zone.myapp_private_hosted_zone.id}"
 name    = "subdomain.myapp"
 type    = "A"
 ttl     = "300"
 records = ["${aws_eip.myapp_eip.public_ip}"]
}
