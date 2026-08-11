# ADR 0001: uso de AWS RDS PostgreSQL

## Status

Aceito

## Contexto

O Tech Challenge exige banco gerenciado, operacao com foco corporativo, seguranca, observabilidade e pipeline automatizada. O repositorio `autoservice-infra-db` precisa sustentar ambientes de homologacao e producao com configuracao consistente e baixo atrito operacional.

## Decisao

Adotar Amazon RDS for PostgreSQL como plataforma padrao de banco gerenciado deste ecossistema.

## Consequencias

### Positivas

- reduz operacao manual de backup, patching e alta disponibilidade
- permite integrar metricas e logs ao ecossistema nativo da AWS
- suporta modelagem relacional consistente para clientes, veiculos e ordens de servico
- simplifica a estrategia de infraestrutura como codigo com Terraform

### Negativas

- cria acoplamento inicial com AWS
- exige controle cuidadoso de custos entre homologacao e producao
- demanda definicao previa de rede privada, secrets e IAM

## Alternativas consideradas

1. Amazon Aurora PostgreSQL: mais escalavel, porem com custo e complexidade maiores para a fase inicial.
2. Amazon RDS MySQL: viavel tecnicamente, mas menos aderente ao uso intensivo de constraints e consultas analiticas previstas.
3. Banco autogerenciado em Kubernetes: descartado por aumentar a carga operacional e reduzir a confiabilidade da camada de dados.

