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
| [kubernetes_secret.name](https://registry.terraform.io/providers/hashicorp/kubernetes/2.32.0/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Annotations for image pull secret | `map(string)` | `null` | no |
| <a name="input_custom_labels"></a> [custom\_labels](#input\_custom\_labels) | (Optional) Add custom label to image pull secret | `map(string)` | `null` | no |
| <a name="input_email"></a> [email](#input\_email) | (Optional) Add email registry to image pull secret | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the image pull secret | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) Namespace in which to create the image pull secret | `string` | `"default"` | no |
| <a name="input_password"></a> [password](#input\_password) | (Optional) Add password registry to image pull secret | `string` | `null` | no |
| <a name="input_server"></a> [server](#input\_server) | (Optional) Add server registry to image pull secret | `string` | `null` | no |
| <a name="input_username"></a> [username](#input\_username) | (Optional) Add username registry to image pull secret | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Name |
<!-- END_TF_DOCS -->
