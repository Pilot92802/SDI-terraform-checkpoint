variable "image_id" {
  description = "ami id of our instance"
  type        = string
  default     = "ami-003946151dbec5c44"
}

variable "jar-file-name" {
  description = "file path to jar file"
  type        = string
  default     = "build/libs/g-hello-0.0.1-SNAPSHOT.jar"
}