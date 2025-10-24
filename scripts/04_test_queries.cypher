// Consulta para listar os 10 filmes mais assistidos,
MATCH (u:User)-[r:RATED]->(m:Media)
WHERE m.tipo = 'Movie' // Filtra para incluir apenas filmes
RETURN m.titulo AS Filme,
       count(r) AS TotalAvaliacoes,
       avg(r.rating) AS AvaliaçãoMédia,
       max(r.rating) AS MelhorNota
ORDER BY TotalAvaliacoes DESC, AvaliaçãoMédia DESC
LIMIT 10;

// Consulta para encontrar atores que colaboraram mais de uma vez com o diretor Christopher Nolan
MATCH (d:Person)-[:DIRECTED]->(m:Media)<-[:ACTED_IN]-(a:Person)
WHERE d.nome = "Christopher Nolan" // Usa 'nome' para a propriedade de Pessoa
WITH a, count(m) AS colaborações
WHERE colaborações > 1
RETURN a.nome AS Ator, colaborações
ORDER BY colaborações DESC;

// Consulta para recomendar filmes para o usuário Ana com base em seus gêneros preferidos
MATCH (u:User {nome: "Ana"})-[:RATED]->(m:Media)
WHERE m.tipo = 'Movie' // Filtra a mídia para ser apenas 'Movie'
MATCH (m)-[:HAS_GENRE]->(g:Genre)
WITH u, g, count(*) AS preferência
ORDER BY preferência DESC
LIMIT 3

// Busca filmes não assistidos nesses gêneros
MATCH (g)<-[:HAS_GENRE]-(recomendação:Media)
WHERE recomendação.tipo = 'Movie'
AND NOT EXISTS((u)-[:RATED]->(recomendação)) // Confirma que Ana não avaliou (:RATED)

RETURN DISTINCT recomendação.titulo AS Recomendação,
       g.nome AS Gênero,
       preferência AS ScoreGênero
ORDER BY ScoreGênero DESC
LIMIT 5;

// Consulta para listar os 10 atores com mais filmes avaliados e suas avaliações médias
MATCH (p:Person)-[:ACTED_IN]->(m:Media)<-[r:RATED]-(u:User)
WHERE m.tipo = 'Movie' // Filtra para incluir apenas filmes
RETURN p.nome AS Ator,
       count(DISTINCT m) AS Filmes,
       count(r) AS TotalAvaliacoes, // Contagem de todas as avaliações recebidas pelos filmes do ator
       avg(r.rating) AS AvaliaçãoMédia
ORDER BY TotalAvaliacoes DESC, AvaliaçãoMédia DESC
LIMIT 10;