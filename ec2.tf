resource "aws_instance" "webapp" {
  ami 		= lookup(var.ami_id, var.region)
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sg_22_80_443.id}"]
  key_name 	= var.key_name 


  user_data = <<-EOF
              #!/bin/bash
             sudo  yum update -y
             sudo  yum install -y httpd
             sudo  systemctl start httpd.service
             sudo  systemctl enable httpd.service
             echo "Hello, World. How is everyone doing" > /var/www/html/index.html
             nohup busybox httpd -f -p 8080 &
             mkdir /opt/terraform
             cd /opt/terraform && wget https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip
             sudo unzip ./terraform_0.13.3_linux_amd64.zip -d /usr/bin
             EOF
  tags = {
    Name = "webapp_east1"
  }
   provisioner "local-exec" {
    command = "echo ${aws_instance.webapp.public_ip} >> /home/ec2-user/public_ip.txt"
  } 
}

