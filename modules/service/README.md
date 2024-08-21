Terraform module for Kubernetes Service
==========================================

## Usage (more in example direcotry)

With default labels, selector finds pods with `app` label which equal to `app_name`

### Example with ClusterIP
```
module "service_jenkins_ClusterIP" {
  source = "../"
  
  app_name      = "jenkins1"
  app_namespace = "jenkins1"
  port_mapping  = var.port_mapping_CI
}
```

### Example with Load Balancer
```
module "service_jenkins_LB" {
  source = "../"
  app_name         = "jenkins2"
  app_namespace    = "jenkins2"
  port_mapping     = var.port_mapping_LB
  type             = "LoadBalancer"
  
  load_balancer_ip            = "134.13.13.24" // This field will be ignored if the cloud-provider does not support the feature
  load_balancer_ips_whitelist = [
    "10.10.10.0/24",
    "34.23.145.91/32"
  ]
}
```
### Example with Node Port
```
module "service_jenkins_NP" {
  source = "../"
  
  app_name      = "jenkins3"
  app_namespace = "jenkins3"
  port_mapping  = var.port_mapping_NP
  type          = "NodePort"
}
```


## Terraform Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| kubernetes | >= 2.0.0 |

## Inputs
See in example directory & variables.tf

## Outputs
| Name       |              Description               |
|------------|:--------------------------------------:|
| name       |          Name of the service           |
| namespace  | Namespace in which created the service |
| id         |         Kubernetes resource id         |
| node_ports |   All Node Ports generated & entered   |
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.32.0/docs/resources/service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | (Optional) Add annotations | `map(string)` | `{}` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | (Required) Application name for attach to service | `string` | n/a | yes |
| <a name="input_app_namespace"></a> [app\_namespace](#input\_app\_namespace) | (Required) Namespace where located application | `string` | n/a | yes |
| <a name="input_custom_labels"></a> [custom\_labels](#input\_custom\_labels) | (Optional) Custom labels & selector | `map(string)` | `null` | no |
| <a name="input_load_balancer_ip"></a> [load\_balancer\_ip](#input\_load\_balancer\_ip) | (Optional) !!!Only applies with type = LoadBalancer!!! Define External Static IP address. | `string` | `null` | no |
| <a name="input_load_balancer_ips_whitelist"></a> [load\_balancer\_ips\_whitelist](#input\_load\_balancer\_ips\_whitelist) | (Optional) !!!Only applies with type = LoadBalancer!!! Define IPs cidr range for whitelist in Load Balancer. By default accept all IPs. | `list(string)` | `null` | no |
| <a name="input_port_mapping"></a> [port\_mapping](#input\_port\_mapping) | (Required) Mapping ports from container to expose port | <pre>list(object({<br>    name        = string<br>    port        = number<br>    protocol    = optional(string)<br>    node_port   = optional(number)<br>    target_port = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Optional) Default is ClusterIP. Can accept: NodePort , LoadBalancer . | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | K8S Resource id |
| <a name="output_name"></a> [name](#output\_name) | K8S Service Name |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_node_ports"></a> [node\_ports](#output\_node\_ports) | Ports |
<!-- END_TF_DOCS -->