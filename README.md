# autoservice-infra-db — Fase 3/4

Infraestrutura como código do **Amazon RDS for PostgreSQL** — ambientes `homolog` e `prod`.

Usado na **Fase 3** (auth/cadastro) e mantido na **Fase 4** (Lambda `cpf-auth` consulta o schema `cadastro`; os MS da saga usam Postgres/Mongo no mesh do EKS para isolamento da demo).

## Qualidade / CI

| Item | Status |
|------|--------|
| IaC | Terraform |
| CI/CD | `.github/workflows/terraform.yml` — `fmt` + `validate`; apply por branch |
| Segredos | AWS Secrets Manager / tfvars (não versionar senhas) |

## Propósito

- Provisionar RDS PostgreSQL por ambiente
- Expor outputs (`jdbc_url`, variáveis da Lambda, security groups)
- Documentar modelagem (ADR/RFC em `docs/`)

## Ecossistema

| Repositório | Papel |
|-------------|--------|
| **autoservice-infra-db** (este) | Terraform RDS |
| `autoservice-lambda-auth` | Consulta CPF no schema `cadastro` |
| `autoservice-infra-k8s` | SGs e subnets liberados no RDS |
| Microsserviços Fase 4 | Mesh Postgres/Mongo no cluster (demo) |

## Tecnologias

| Item | Escolha |
|------|---------|
| Cloud | AWS |
| Banco | Amazon RDS for PostgreSQL |
| IaC | Terraform |

## Modelo (visão geral)

Schemas principais da autenticação/cadastro: **`cadastro`** e **`servico`**.

Detalhes: `docs/model/`, `docs/adr/`, `docs/rfc/`.

## Uso

```bash
copy terraform\environments\homolog\terraform.tfvars.example terraform\environments\homolog\terraform.tfvars
# defina TF_VAR_db_password fora do Git
cd terraform\environments\homolog
terraform init -backend-config=..\..\backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## CI/CD

| Evento | Ação |
|--------|------|
| Pull request | Test (`fmt` + `validate`) |
| Push `develop` | Deploy homolog |
| Push `main` | Deploy prod |
