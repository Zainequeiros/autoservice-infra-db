locals {
  name = "autoservice-db"

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Repository  = "autoservice-infra-db"
    },
    var.tags
  )
}
