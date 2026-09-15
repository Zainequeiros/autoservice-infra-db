# Integração RDS com EKS e Lambda

Para a aplicação no EKS e a função `cpf-auth` alcançarem o PostgreSQL:

1. Nos outputs do `autoservice-infra-k8s`, use:
   - `eks_nodes_security_group_id`
   - `lambda_auth_security_group_id`
   - `private_subnet_ids` (quando a Lambda estiver em VPC)
2. No Terraform deste repositório, configure `allowed_security_group_ids` com esses SGs.
3. Na Lambda e no Secret da aplicação, use o mesmo segredo JWT (`JWT_SECRET` / `AUTOSERVICE_JWT_SECRET`) e as credenciais do RDS (`DB_*` / JDBC).

Schemas utilizados pela aplicação/Lambda: `cadastro` e `servico`.
