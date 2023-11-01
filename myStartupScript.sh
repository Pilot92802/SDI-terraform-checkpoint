#!bin/bash
yum update -y
yum install -y httpd
yum install -y java-11-amazon-corretto-headless
systemctl start httpd
systemctl enable httpd
aws s3api get-object --bucket "cjd-chkpt-bucket" --key "g-hello.jar" "g-hello-0.0.1-SNAPSHOT.jar"
java -jar g-hello-0.0.1-SNAPSHOT.jar