variable "function_name" {
  description = "Name of the OpenFaaS function"
  type        = string
  default     = "hello-python"
}

variable "function_image" {
  description = "Docker image for the function"
  type        = string
  default     = "allupranathi10/hello-python:latest"
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
  default     = 1
}
