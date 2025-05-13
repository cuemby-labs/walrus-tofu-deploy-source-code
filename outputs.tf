#
# Contextual output
#

output "walrus_project_name" {
  value       = try(local.context["project"]["name"], null)
  description = "The name of project where deployed in Walrus."
}

output "walrus_project_id" {
  value       = try(local.context["project"]["id"], null)
  description = "The id of project where deployed in Walrus."
}

output "walrus_environment_name" {
  value       = try(local.context["environment"]["name"], null)
  description = "The name of environment where deployed in Walrus."
}

output "walrus_environment_id" {
  value       = try(local.context["environment"]["id"], null)
  description = "The id of environment where deployed in Walrus."
}

output "walrus_resource_name" {
  value       = try(local.context["resource"]["name"], null)
  description = "The name of resource where deployed in Walrus."
}

output "walrus_resource_id" {
  value       = try(local.context["resource"]["id"], null)
  description = "The id of resource where deployed in Walrus."
}

output "walrus_endpoints" {
  value = {
    internal_url        = data.kubernetes_resource.knative.object.status.address.url
    # internal_service_ip = data.kubernetes_service.service.spec[0].cluster_ip
    external_url        = data.kubernetes_resource.knative.object.status.url
    # load_balancer_ip    = var.ingress_enabled ? data.kubernetes_ingress_v1.ingress.status[0].load_balancer[0].ingress[0].ip : ""
  }
  description = "URL of the service"
}

# output "service_ip" {
#   description = "Service IP"
#   value       = data.kubernetes_service.service.spec[0].cluster_ip
# }

output "ports" {
  description = "Service Ports"
  value       = var.ports
}

output "image" {
  description = "Built docker image name"
  value       = var.image
}