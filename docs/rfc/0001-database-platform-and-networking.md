# RFC 0001: plataforma de banco e estrategia de rede

## Problema

O sistema da oficina passou a operar com multiplas unidades e crescimento de clientes. O banco precisa suportar autenticacao por CPF, abertura de ordens de servico, monitoramento, integracoes e futura expansao sem expor dados sensiveis diretamente na internet.

## Proposta

Provisionar PostgreSQL gerenciado em AWS RDS, em subnets privadas, com acesso restrito por Security Group e CIDRs internos do cluster Kubernetes e componentes autorizados.

## Decisoes da proposta

1. PostgreSQL como banco relacional principal pela capacidade de modelagem consistente, indices, constraints e suporte a consultas operacionais.
2. Banco em subnets privadas, sem `publicly_accessible`.
3. Separacao de configuracao entre homolog e prod via `tfvars`.
4. Integracao da observabilidade por logs exportados ao CloudWatch, viabilizando ingestao por Datadog ou New Relic.
5. Pipeline automatizada para validacao em PR e apply por branch de ambiente.

## Impactos esperados

- maior previsibilidade de deploy e rollback da infraestrutura
- reducao de risco de exposicao indevida do banco
- base consistente para implementar SLIs de latencia, uptime e falhas operacionais

## Pontos em aberto

- definicao final do mecanismo de ingestao de observabilidade externa
- estrategia de rotacao de senha e integracao com AWS Secrets Manager
- politica de backup e retention final conforme custo aprovado pelo grupo

