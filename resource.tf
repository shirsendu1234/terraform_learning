resource "aws_instance" "myapp_ec2_instance" {
 ami               = "ami-21f78e11"
 availability_zone = "${var.availability_zone}"
 instance_type     = "${var.instance_type}"

 tags {
   Name = "myapp-EC2-instance"
 }
}

resource "aws_ebs_volume" "myapp_ebs_volume" {
 availability_zone = "${var.availability_zone}"
 size              = 1

  tags {
   Name = "myapp-EBS-volume"
 }
}

resource "aws_volume_attachment" "myapp_vol_attachment" {
 device_name = "/dev/sdh"
 volume_id   = "${aws_ebs_volume.myapp_ebs_volume.id}"
 instance_id = "${aws_instance.myapp_ec2_instance.id}"
}
