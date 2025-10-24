// Constraint para Pessoas (nodes:Person)
// Garante que o ID da pessoa seja único.
CREATE CONSTRAINT IF NOT EXISTS FOR (p:Person) REQUIRE p.id IS UNIQUE;

// Constraint para Mídia (nodes:Media)
// Garante que o ID da mídia (M1, M2, etc.) seja único.
CREATE CONSTRAINT IF NOT EXISTS FOR (m:Media) REQUIRE m.id IS UNIQUE;

// Constraint para Gêneros (nodes:Genre)
// Garante que o ID do gênero seja único.
CREATE CONSTRAINT IF NOT EXISTS FOR (g:Genre) REQUIRE g.id IS UNIQUE;

// Constraint para Usuários (nodes:User)
// Garante que o ID do usuário seja único.
CREATE CONSTRAINT IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE;