# Reference the existing subnet
output "aws_subnet_id" {
  value = aws_subnet.existing.id  # Existing subnet ID
}
