# autoservice-infra-db

Infraestrutura como código do **banco de dados gerenciado** (Amazon RDS for PostgreSQL) do Autoservice — ambientes `homolog` e `prod`.

## Propósito

- Provisionar RDS PostgreSQL por ambiente via Terraform
- Expor outputs (`jdbc_url`, variáveis da Lambda, security groups) para app e autenticação
- Documentar modelagem e decisões (ADR/RFC em `docs/`)
- CI/CD com validação e apply automatizados

## Ecossistema

| Repositório | Papel |
|-------------|--------|
| **autoservice-infra-db** (este) | Terraform RDS |
| `autoservice` / microsserviços | Consumo JDBC / schemas |
| `autoservice-lambda-auth` | Consulta CPF no schema `cadastro` |
| `autoservice-infra-k8s` | SGs e subnets liberados no RDS |

## Tecnologias

| Item | Escolha |
|------|---------|
| Cloud | AWS |
| Banco | Amazon RDS for PostgreSQL |
| IaC | Terraform |
| Segredos | AWS Secrets Manager |
| CI/CD | GitHub Actions (`.github/workflows/terraform.yml`) |

## Modelo (visão geral)

Schemas principais usados pela autenticação e cadastro: **`cadastro`** e **`servico`**.

```text
PESSOA ──┬── PESSOA_FISICA (cpf)
         └── PESSOA_JURIDICA (cnpj)
PESSOA ──── CLIENTE
PESSOA ──── VEICULO ──── TIPO_VEICULO
VEICULO ─── ORDEM_SERVICO ─── ITEM_SERVICO
```

Detalhes: `docs/model/`, `docs/adr/`, `docs/rfc/`.

## Uso local

```bash
copy terraform\environments\homolog\terraform.tfvars.example terraform\environments\homolog\terraform.tfvars
# preencher rede, instância e allowed_security_group_ids
set TF_VAR_db_password=troque-esta-senha
cd terraform\environments\homolog
terraform init -backend-config=..\..\backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## CI/CD

Workflow: `.github/workflows/terraform.yml` (`CI/CD Terraform`).

| Evento | Ação |
|--------|------|
| Pull request | Test (`fmt` + `validate`) |
| Push `develop` | Deploy homolog |
| Push `main` | Deploy prod |

Secrets: credenciais AWS, bucket/lock do state, senhas/tfvars por ambiente.
