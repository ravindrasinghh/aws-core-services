resource "aws_key_pair" "mykey" {
  key_name   = "${var.tier}-assort"
  public_key = "${file("${var.public-key}")}"
  lifecycle {
    ignore_changes = ["public_key"]
  }
}