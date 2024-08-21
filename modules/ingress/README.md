# Submodule

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
| [kubernetes_ingress_v1.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/2.32.0/docs/resources/ingress_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | (Optional) Add annotations | `map(string)` | `{}` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | (Required) Application name for attach to service | `string` | n/a | yes |
| <a name="input_app_namespace"></a> [app\_namespace](#input\_app\_namespace) | (Required) Namespace where located application | `string` | n/a | yes |
| <a name="input_custom_labels"></a> [custom\_labels](#input\_custom\_labels) | (Optional) Custom labels & selector | `map(string)` | `null` | no |
| <a name="input_default_backend"></a> [default\_backend](#input\_default\_backend) | n/a | <pre>list(object({<br>    resource = list(object({<br>      name      = optional(string)<br>      api_group = optional(string)<br>      kind      = optional(string)<br>    }))<br>    service = list(object({<br>      name        = optional(string)<br>      port_name   = optional(string)<br>      port_number = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_http_rules"></a> [http\_rules](#input\_http\_rules) | n/a | <pre>list(object({<br>    host                = string<br>    path                = optional(string)<br>    path_type           = optional(string)<br>    resource_name       = optional(string)<br>    resource_api_group  = optional(string)<br>    resource_kind       = optional(string)<br>    service_name        = optional(string)<br>    service_port_name   = optional(string)<br>    service_port_number = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_class_name"></a> [ingress\_class\_name](#input\_ingress\_class\_name) | n/a | `string` | `null` | no |
| <a name="input_tls_rules"></a> [tls\_rules](#input\_tls\_rules) | n/a | <pre>list(object({<br>    hosts       = list(string)<br>    secret_name = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | n/a |
<!-- END_TF_DOCS -->
