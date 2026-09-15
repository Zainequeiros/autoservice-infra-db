# Status de Aderencia ao Escopo - Tech Challenge (`autoservice-infra-db`)

Data de referencia: 2026-08-21  
Repositorio avaliado: `autoservice-infra-db`  
Papel no ecossistema: **Infraestrutura do Banco de Dados Gerenciado (Terraform)**

## 1) Resumo executivo

Este repositorio esta **bem aderente ao papel de infra de banco gerenciado** dentro do modelo de 4 repositorios do Tech Challenge.  
Ja contempla provisionamento de RDS PostgreSQL com foco em seguranca, ambientes separados (`homolog`/`prod`), CI/CD Terraform e documentacao tecnica (RFC, ADR e justificativa de modelo relacional).

As principais pendencias para fechamento total estao em **evidencias finais de entrega** (links reais de deploy) e em **integracao operacional com os demais repositorios** (consumo de outputs, observabilidade externa e comprovacoes fim-a-fim).

---

## 2) O que ja foi feito neste repositorio, e por que

## 2.1 Provisionamento de banco gerenciado com Terraform

### O que foi implementado
- Modulo dedicado `terraform/modules/managed_postgres` para criar:
  - `aws_db_instance` (PostgreSQL RDS);
  - `aws_db_subnet_group`;
  - `aws_security_group` e regras de ingresso por CIDR e por Security Group;
  - `aws_db_parameter_group` com parametros de seguranca e observabilidade.
- Stack raiz em `terraform/` consumindo o modulo.

### Por que foi implementado
- Atender ao requisito obrigatorio de **Banco de Dados Gerenciado**.
- Reduzir carga operacional (backup, patching, disponibilidade e monitoramento nativo).
- Padronizar provisionamento com IaC reutilizavel e rastreavel.

## 2.2 Seguranca e hardening da camada de dados

### O que foi implementado
- Banco com `publicly_accessible = false`.
- Criptografia em repouso (`storage_encrypted = true`).
- Controle de acesso por rede:
  - `allowed_security_group_ids` (preferencial);
  - `allowed_cidrs` (uso controlado).
- `deletion_protection`, janela de manutencao e backup retention configuraveis por ambiente.
- Exportacao de logs PostgreSQL para CloudWatch (`enabled_cloudwatch_logs_exports`).

### Por que foi implementado
- Atender os requisitos de **seguranca**, **alta disponibilidade** e **operacao corporativa**.
- Minimizar risco de exposicao do banco e de exclusao acidental.

## 2.3 Separacao de ambientes homolog/prod

### O que foi implementado
- Estrutura isolada por ambiente em:
  - `terraform/environments/homolog`
  - `terraform/environments/prod`
- Defaults e capacidade diferentes por ambiente (ex.: `multi_az` e tamanho de instancia).

### Por que foi implementado
- Atender ao requisito de deploy por ambiente e reduzir risco de mudanca em producao.
- Permitir evolucao incremental e testes realistas em homologacao.

## 2.4 CI/CD com deploy automatico por branch de ambiente

### O que foi implementado
- Workflow `.github/workflows/terraform.yml` com:
  - `pull_request` em `homolog` e `prod`: `fmt`, `init -backend=false`, `validate`;
  - `push` em `homolog`/`prod`: `init`, `plan`, `apply` automaticos.
- Uso de OIDC com role AWS (`aws-actions/configure-aws-credentials`).
- Uso de secrets para `tfvars`, backend remoto e senha do banco.

### Por que foi implementado
- Atender ao requisito de **CI/CD funcional** e **deploy automatico** por branch de ambiente.
- Aumentar confiabilidade do processo de mudanca de infraestrutura.

## 2.5 Contrato de integracao com os outros repositorios

### O que foi implementado
- Outputs para consumo cruzado:
  - `jdbc_url`
  - `db_username`
  - `lambda_environment` (`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`)
  - `autoservice_environment`
  - `security_group_id`
- README com orientacoes de wiring entre repositorios.

### Por que foi implementado
- Garantir acoplamento explicito e controlado entre:
  - app principal (`autoservice`);
  - Lambda auth (`autoservice-lambda-auth`);
  - infra k8s (`autoservice-infra-k8s`).

## 2.6 Documentacao arquitetural e de dados

### O que foi implementado
- README com escopo, arquitetura, CI/CD, estrutura e operacao.
- RFC: `docs/rfc/0001-database-platform-and-networking.md`.
- ADR: `docs/adr/0001-use-aws-rds-postgresql.md`.
- Justificativa de banco + modelo ER conceitual:
  - `docs/model/database-rationale.md`.

### Por que foi implementado
- Atender ao requisito de **documentacao de arquitetura** e de **justificativa formal do banco/modelo relacional**.

---

## 3) Aderencia por requisito do Tech Challenge (foco neste repo)

| Requisito | Status neste repo | Observacao |
| --- | --- | --- |
| Infra de Banco Gerenciado | Atendido | RDS PostgreSQL provisionado por Terraform |
| Terraform para provisionamento | Atendido | Estrutura modular + ambientes |
| CI/CD no repositorio | Atendido | Validate em PR + apply em push homolog/prod |
| Deploy automatico homolog/prod | Atendido no escopo DB | Depende de secrets e branch strategy corretos |
| Seguranca do banco | Atendido | Subnets privadas, SG restrito, criptografia, protecao de exclusao |
| Observabilidade da camada DB | Parcialmente atendido | Logs/metricas CloudWatch prontos; integracao externa (Datadog/New Relic) ainda depende do observability stack final |
| Documentacao arquitetural deste repo | Atendido | README + RFC + ADR + modelo/justificativa |
| Swagger/Postman | Nao aplicavel ao repo | Este repo nao expoe API HTTP |
| Dockerfile | Nao aplicavel ao repo | Entrega de Terraform/documentacao |

---

## 4) O que ainda precisa ser implementado/fechado

## 4.1 Pendencias internas deste repositorio

1. Substituir placeholders de links de deploy no `README.md`:
   - `<rds-homolog-endpoint>`
   - `<rds-prod-endpoint>`
2. Registrar evidencias reais de `terraform apply` por ambiente (print/log da pipeline e outputs finais).
3. Consolidar politica final de backup/retention e estrategia de rotacao de credenciais (secrets manager/rotacao operacional), conforme decisao do grupo.

## 4.2 Pendencias de integracao com os outros 3 repositorios

1. Confirmar consumo real dos outputs deste repo:
   - `autoservice` usando `SPRING_DATASOURCE_*`;
   - `autoservice-lambda-auth` usando `DB_*`.
2. Garantir whitelist de rede final:
   - `allowed_security_group_ids` incluindo SG do EKS e da Lambda.
3. Validar fluxo fim-a-fim:
   - autenticacao por CPF via Lambda;
   - consumo de API protegida;
   - persistencia/consulta no RDS provisionado aqui.

## 4.3 Pendencias para entrega final da fase (grupo)

1. Confirmar branch protection e PR obrigatorio nos 4 repositorios.
2. Publicar todos os links finais (repos, deploys, docs, Swagger/Postman, video).
3. Fechar dashboards/alertas obrigatorios com evidencia operacional.
4. Montar PDF unico para Portal do Aluno com:
   - links dos 4 repositorios;
   - link do video (<= 15 min);
   - links de documentacoes;
   - confirmacao do usuario `soat-architecture`.

---

## 5) Riscos e pontos de atencao

- **Risco de aderencia incompleta por evidencia:** tecnicamente o repo esta maduro, mas sem links/evidencias finais a entrega pode ser considerada parcial.
- **Risco de integracao de rede:** sem SGs corretos entre EKS/Lambda/RDS, o fluxo autenticacao + consumo de APIs pode falhar.
- **Risco de observabilidade fragmentada:** CloudWatch esta pronto na base, mas dashboards obrigatorios do desafio dependem da camada consolidada nos demais repositorios/ferramenta final.

---

## 6) Conclusao

No escopo de `autoservice-infra-db`, o trabalho esta **majoritariamente concluido** e alinhado ao Tech Challenge: banco gerenciado, Terraform, CI/CD, seguranca e documentacao tecnica estao implementados.  
Para fechar 100%, faltam principalmente **evidencias finais**, **wiring operacional entre repositorios** e **comprovacao de requisitos integrados** na demonstracao final do grupo.
