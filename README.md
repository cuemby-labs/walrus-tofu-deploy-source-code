# Awesome Walrus Template

Start here to create an awesome Walrus template.

## Usage

```hcl

```

## Examples

- ...
- ...

## Contributing

Please read our [contributing guide](./docs/CONTRIBUTING.md) if you're interested in contributing to Walrus template.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_kaniko"></a> [kaniko](#requirement\_kaniko) | 0.0.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.32.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kaniko"></a> [kaniko](#provider\_kaniko) | 0.0.3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.32.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deployment"></a> [deployment](#module\_deployment) | ./modules/deployment | n/a |
| <a name="module_image_pull_secrets"></a> [image\_pull\_secrets](#module\_image\_pull\_secrets) | ./modules/image-pull-secret | n/a |
| <a name="module_ingress"></a> [ingress](#module\_ingress) | ./modules/ingress | n/a |
| <a name="module_service"></a> [service](#module\_service) | ./modules/service | n/a |
| <a name="module_keda"></a> [keda](#module\_keda) | ./modules/keda | n/a |

## Resources

| Name | Type |
|------|------|
| [kaniko_image.image](https://registry.terraform.io/providers/seal-io/kaniko/0.0.3/docs/resources/image) | resource |
| [null_resource.wait_for_url](https://registry.terraform.io/providers/hashicorp/null/3.2.3/docs/resources/resource) | resource |
| [kubernetes_ingress_v1.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/2.32.0/docs/data-sources/ingress_v1) | data source |
| [kubernetes_secret.image_pull_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.32.0/docs/data-sources/secret) | data source |
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.32.0/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.<br><br>Examples:<pre>context:<br>  project:<br>    name: string<br>    id: string<br>  environment:<br>    name: string<br>    id: string<br>  resource:<br>    name: string<br>    id: string</pre> | `map(any)` | `{}` | no |
| <a name="input_dockerfile"></a> [dockerfile](#input\_dockerfile) | Path to the Dockerfile. | `string` | `"Dockerfile"` | no |
| <a name="input_env"></a> [env](#input\_env) | Name and value pairs to set as the environment variables | `map(string)` | `{}` | no |
| <a name="input_git_auth"></a> [git\_auth](#input\_git\_auth) | Git authentication enabled. | `bool` | `false` | no |
| <a name="input_git_branch"></a> [git\_branch](#input\_git\_branch) | Branch of the repository to clone. | `string` | `"main"` | no |
| <a name="input_git_password"></a> [git\_password](#input\_git\_password) | Password for cloning the git repository. | `string` | `null` | no |
| <a name="input_git_url"></a> [git\_url](#input\_git\_url) | URL to the source code repository. | `string` | n/a | yes |
| <a name="input_git_username"></a> [git\_username](#input\_git\_username) | Username for cloning the git repository. | `string` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | Name of the image to be built and deployed. | `string` | n/a | yes |
| <a name="input_ingress_annotations"></a> [ingress\_annotations](#input\_ingress\_annotations) | (Optional) Add annotations | `map(string)` | `{}` | no |
| <a name="input_ingress_class_name"></a> [ingress\_class\_name](#input\_ingress\_class\_name) | (Optional) Add an ingress class name. | `string` | `"nginx"` | no |
| <a name="input_ingress_enabled"></a> [ingress\_enabled](#input\_ingress\_enabled) | (Optional) Enabled exposing via ingress. | `bool` | `false` | no |
| <a name="input_ingress_host"></a> [ingress\_host](#input\_ingress\_host) | (Optional) Add ingress host. | `string` | `""` | no |
| <a name="input_ingress_tls_enabled"></a> [ingress\_tls\_enabled](#input\_ingress\_tls\_enabled) | (Optional) Enabled TLS. | `bool` | `false` | no |
| <a name="input_limit_cpu"></a> [limit\_cpu](#input\_limit\_cpu) | CPU limit. e.g. 0.5, 1, 2 | `string` | `""` | no |
| <a name="input_limit_memory"></a> [limit\_memory](#input\_limit\_memory) | Memory limit. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the deployment resource. Auto-generated if empty. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy. Auto-generated if empty. | `string` | `""` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | Service ports to expose | `list(number)` | <pre>[<br>  80<br>]</pre> | no |
| <a name="input_registry_auth"></a> [registry\_auth](#input\_registry\_auth) | Registry authentication enabled. | `bool` | `false` | no |
| <a name="input_registry_password"></a> [registry\_password](#input\_registry\_password) | Password for the image registry. | `string` | `null` | no |
| <a name="input_registry_server"></a> [registry\_server](#input\_registry\_server) | Server for the image registry. | `string` | `"docker.io"` | no |
| <a name="input_registry_username"></a> [registry\_username](#input\_registry\_username) | Username for the image registry. | `string` | `null` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Count of pods | `number` | `1` | no |
| <a name="input_request_cpu"></a> [request\_cpu](#input\_request\_cpu) | CPU request. e.g. 0.5, 1, 2 | `string` | `"0.1"` | no |
| <a name="input_request_memory"></a> [request\_memory](#input\_request\_memory) | Memory request. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi | `string` | `"128Mi"` | no |
| <a name="input_walrus_metadata_namespace_name"></a> [walrus\_metadata\_namespace\_name](#input\_walrus\_metadata\_namespace\_name) | Walrus metadata namespace name. | `string` | `""` | no |
| <a name="input_walrus_metadata_service_name"></a> [walrus\_metadata\_service\_name](#input\_walrus\_metadata\_service\_name) | Walrus metadata service name. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image"></a> [image](#output\_image) | Built docker image name |
| <a name="output_ports"></a> [ports](#output\_ports) | Service Ports |
| <a name="output_service_ip"></a> [service\_ip](#output\_service\_ip) | Service IP |
| <a name="output_walrus_endpoints"></a> [walrus\_endpoints](#output\_walrus\_endpoints) | URL of the service |
| <a name="output_walrus_environment_id"></a> [walrus\_environment\_id](#output\_walrus\_environment\_id) | The id of environment where deployed in Walrus. |
| <a name="output_walrus_environment_name"></a> [walrus\_environment\_name](#output\_walrus\_environment\_name) | The name of environment where deployed in Walrus. |
| <a name="output_walrus_project_id"></a> [walrus\_project\_id](#output\_walrus\_project\_id) | The id of project where deployed in Walrus. |
| <a name="output_walrus_project_name"></a> [walrus\_project\_name](#output\_walrus\_project\_name) | The name of project where deployed in Walrus. |
| <a name="output_walrus_resource_id"></a> [walrus\_resource\_id](#output\_walrus\_resource\_id) | The id of resource where deployed in Walrus. |
| <a name="output_walrus_resource_name"></a> [walrus\_resource\_name](#output\_walrus\_resource\_name) | The name of resource where deployed in Walrus. |
<!-- END_TF_DOCS -->

## License

Copyright (c) 2023 [Seal, Inc.](https://seal.io)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [LICENSE](./LICENSE) file for details.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
