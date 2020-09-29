resource "aws_instance" "webapp" {
  ami 		= lookup(var.ami_id, var.region)
  instance_type = "t2.micro"
  key_name 	= var.key_name 

  user_data = <<-EOF
              #!/bin/bash
             sudo  yum update -y
             sudo  yum install -y httpd
             sudo  systemctl start httpd.service
             sudo  systemctl enable httpd.service
              echo "Hello, World. How is everyone doing" > /var/www/html/index.html
              #nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "webapp_east1"
  } 
}

