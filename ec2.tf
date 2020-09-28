resource "aws_instance" "webapp" {
  ami 		= lookup(var.ami_id, var.region)
  instance_type = "t2.micro"
  key_name 	= "class02webapp" 

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd.service
              systemctl enable httpd.service
              echo "Hello, World. How is everyone doing" > /var/www/html/index.html
              #nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "webapp_east1"
  } 
}

