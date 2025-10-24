# 🎬 Consultas de Análise - Grafo de Mídia/Filmes

Este documento lista consultas Cypher importantes para validar e analisar o modelo de dados de Mídia/Usuários.

## 1. Validação e Integridade do Grafo

Estas consultas confirmam que todos os dados foram importados e estão ligados corretamente.

### 1.1 Contagem Total de Nós (Entidades)
Confirma que todos os 10 nós de cada tipo existem.

```cypher
MATCH (n)
RETURN labels(n) AS Tipo, count(n) AS Total;
 ```
#### Resultado Esperado:
| Tipo       | Total |
|:-----------|:-----:|
| ["Person"] |  10   |
| ["media"]  |  10   |
| ["Genre"]  |  10   |
| ["User"]   |  10   |


### 1.2 Contagem de Relacionamentos (Ligações)
Confirma se as relações foram criadas corretamente (RATED, DIRECTED, etc.).
```cypher
MATCH ()-[r]->()
RETURN type(r) AS TipoDeRelacionamento, count(r) AS Contagem;
```

#### Resultado Esperado:
| TipoDeRelacionamento | Contagem |
|:---------------------|:--------:|
| "DIRECTED"           |    6     |
| "ACTED_IN"           |    12    |
| "RATED"              |    15    |
| "HAS_GENRE"          |    10    |


### 1.3 Verificar Ligação entre Nós Específicos
Verifica se o relacionamento de atuação entre P1 (Nolan) e M1 (A Origem) existe.
```cypher
MATCH (p:Person {id: 'P1'})-[r]-(m:Media {id: 'M1'})
RETURN p.nome, type(r), m.titulo;
```
#### Resultado Esperado:
| nome              | type(r)    | titulo     |
|:------------------|:-----------|:-----------|
| "Christopher Nolan" | "DIRECTED" | "A Origem"   |
    

---

## 2. Consultas de Análise (Análise de Conteúdo e Colaboração)

### 2.1 Encontrar Colaboradores de um Diretor (Consulta Corrigida)
Lista atores que trabalharam em mais de um filme dirigido por Christopher Nolan ('P1'). <BR>
Verifica se o relacionamento de atuação entre P1 (Nolan) e M1 (A Origem) existe.
```cypher
MATCH (d:Person {nome: 'Christopher Nolan'})-[:DIRECTED]->(m:Media)<-[:ACTED_IN]-(a:Person)
WITH a, count(m) AS colaborações
WHERE colaborações > 1
RETURN a.nome AS Ator, colaborações
ORDER BY colaborações DESC;
```
#### Resultado Esperado:
| Ator                   | colaborações |
|:-----------------------|:-------------:|
| "Tom Hardy"            |      2      |
| "Cillian Murphy" |      2      |

### 2.2 Filmes por Gênero
Encontra todos os filmes do gênero 'Ficção Científica' ('G2').
```cypher
MATCH (g:Genre {nome: 'Ficção Científica'})<-[:HAS_GENRE]-(m:Media)
RETURN m.titulo AS Filme, m.tipo AS Tipo;
```
#### Resultado Esperado:
| Filme               | Tipo  |
|:--------------------|:------:|
| "A Origem"          | "Movie" |
| "Interstellar"      | "Movie" | 
| "Blade Runner 2049" | "Movie" | 

### 2.3 Filmes Dirigidos por uma Pessoa
Quais filmes a Pessoa 'P5' (Sam Mendes) dirigiu?
```cypher
MATCH (p:Person {id: 'P5'})-[:DIRECTED]->(m:Media)
RETURN m.titulo AS Filme;
```
#### Resultado Esperado:
| Filme  |
|:-------|
| "1917" |

---

## 3. Consultas de Recomendação e Engajamento

### 3.1 Ranking de Popularidade de Atores por Visualizações
Classifica atores pelo total de avaliações que os filmes em que atuaram receberam.
```cypher
MATCH (p:Person)-[:ACTED_IN]->(m:Media)<-[r:RATED]-(u:User)
WHERE m.tipo = 'Movie' // Foco em filmes
RETURN p.nome AS Ator,
count(DISTINCT m) AS Filmes,
count(r) AS TotalAvaliacoes,
avg(r.rating) AS AvaliaçãoMédia
ORDER BY TotalAvaliacoes DESC
LIMIT 5;
```
#### Resultado Esperado:
| Ator                | Filmes | TotalAvaliacoes | AvaliaçãoMédia |
|:--------------------|:------:|:---------------:|:--------------:|
| "Leonardo DiCaprio" |   2    |        4        |      4.27      |   
| "Tom hardy"         |   2    |        3        |      4.33      |
| "Cillian Murphy"    |   2    |        2        |      4.20      |
| "Christian Bale"    |   1    |        1        |      4.9       |    
| "Ryan Gosling"      |   1    |        1        |      4.2       |     


### 3.2 Média de Avaliação do Catálogo
Calcula a nota média de todos os filmes no catálogo.
```cypher
MATCH (m:Media)<-[r:RATED]-(u:User)
RETURN avg(r.rating) AS MediaGeralDoCatalogo;
```
#### Resultado Esperado:
| MediaGeralDoCatalogo |
|:--------------------:|
|         4.38         |