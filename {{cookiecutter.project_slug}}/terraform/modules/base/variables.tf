variable "account_id" {
  description = "The AWS account ID"
  type        = string
  default     = "{{ cookiecutter.aws_account_id }}"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "{{ cookiecutter.aws_region }}"
}

variable "app_name" {
  description = "Application Name"
  type        = string
  default     = "{{ cookiecutter.project_dash }}"
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "sandbox"
}

variable "cluster_name" {
  description = "Name of cluster"
  type        = string
  default     = "{{ cookiecutter.project_dash }}-sandbox"
}

variable "domain_name" {
  type    = string
  default = "sandbox.{{ cookiecutter.domain_name }}"
}

variable "api_domain_name" {
  type    = string
  default = "api.{{ cookiecutter.domain_name }}"
}

variable "cluster_domain_name" {
  type    = string
  default = "k8s.{{ cookiecutter.domain_name }}"
}

variable "argocd_domain_name" {
  type    = string
  default = "argocd.{{ cookiecutter.domain_name }}"
}


variable "prometheus_domain_name" {
  type    = string
  default = "prometheus.{{ cookiecutter.domain_name }}"
}

variable "kubernetes_version" {

  description = "Kubernetes version to use for the cluster, if not set the k8s version shipped with the talos sdk or k3s version will be used"
  type        = string
  default     = null
}

variable "control_plane" {
  description = "Info for control plane that will be created"
  type = object({
    instance_type      = optional(string, "t3a.medium")
    ami_id             = optional(string, "")
    num_instances      = optional(number, 3)
    config_patch_files = optional(list(string), [])
    tags               = optional(map(string), {})
  })

  validation {
    condition     = var.control_plane.ami_id != null ? (length(var.control_plane.ami_id) > 4 && substr(var.control_plane.ami_id, 0, 4) == "ami-") : true
    error_message = "The ami_id value must be a valid AMI id, starting with \"ami-\"."
  }

  # TODO: add cookiecutter.use_talos check 
  default = {
    # curl -sL https://github.com/siderolabs/talos/releases/download/v1.7.4/cloud-images.json | jq -r '.[] | select(.cloud == "aws" and .region == "us-east-1" and .arch == "amd64")'
    ami_id = "ami-04be44740c9604fa2"
  }
}

variable "cluster_vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "172.16.0.0/16"
}

# TODO: add cookiecutter.use_talos check 
variable "config_patch_files" {
  description = "Path to talos config path files that applies to all nodes"
  type        = list(string)
  default     = []
}

variable "repo_name" {
  type    = string
  default = "{{ cookiecutter.repo_name }}"
}

variable "repo_url" {
  type    = string
  default = "{{ cookiecutter.repo_url }}"
}

variable "frontend_ecr_repo" {
  description = "The Frontend ECR repository name"
  type        = string
  default     = "{{ cookiecutter.project_dash }}-sandbox-frontend"
}

variable "backend_ecr_repo" {
  description = "The backend ECR repository name"
  type        = string
  default     = "{{ cookiecutter.project_dash }}-sandbox-backend"
}

variable "kubectl_allowed_ips" {
  description = "A list of CIDR blocks that are allowed to access the kubernetes api"
  type        = string
  default     = ""
}

# TODO: add cookiecutter.use_talos check 
variable "talosctl_allowed_ips" {
  description = "A list of CIDR blocks that are allowed to access the talos api"
  type        = string
  default     = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}
