output "function_name" {
  description = "Deployed function name"
  value       = kubernetes_deployment.hello_python.metadata[0].name
}

output "function_namespace" {
  description = "Namespace of the function"
  value       = kubernetes_deployment.hello_python.metadata[0].namespace
}

output "function_image" {
  description = "Docker image used"
  value       = kubernetes_deployment.hello_python.spec[0].template[0].spec[0].container[0].image
}

output "service_name" {
  description = "Kubernetes service name"
  value       = kubernetes_service.hello_python.metadata[0].name
}
