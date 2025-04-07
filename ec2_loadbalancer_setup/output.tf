output "alb_dns" {
  value = aws_lb.my_alb.dns_name
}

output "server1" {
  value = aws_instance.server1.public_ip
}
output "server2" {
  value = aws_instance.server2.public_ip
}