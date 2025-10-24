// E. ELENCO E DIREÇÃO (CAST_CREW)
MATCH (p1:Person {id: 'P1'}), (p2:Person {id: 'P2'}), (p3:Person {id: 'P3'}), (p4:Person {id: 'P4'}), (p5:Person {id: 'P5'}), (p6:Person {id: 'P6'}), (p7:Person {id: 'P7'}), (p8:Person {id: 'P8'}), (p9:Person {id: 'P9'}), (p10:Person {id: 'P10'})
MATCH (m1:Media {id: 'M1'}), (m2:Media {id: 'M2'}), (m3:Media {id: 'M3'}), (m4:Media {id: 'M4'}), (m5:Media {id: 'M5'}), (m6:Media {id: 'M6'}), (m7:Media {id: 'M7'}), (m8:Media {id: 'M8'}), (m9:Media {id: 'M9'}), (m10:Media {id: 'M10'})

// P1 (Christopher Nolan)
CREATE (p1)-[:DIRECTED]->(m1)
CREATE (p1)-[:DIRECTED]->(m2)
CREATE (p1)-[:DIRECTED]->(m3)
CREATE (p1)-[:DIRECTED]->(m7)

// P2 (Leonardo DiCaprio)
CREATE (p2)-[:ACTED_IN]->(m1)
CREATE (p2)-[:ACTED_IN]->(m8)

// P3 (Cillian Murphy)
CREATE (p3)-[:ACTED_IN]->(m3)
CREATE (p3)-[:ACTED_IN]->(m4)
CREATE (p3)-[:ACTED_IN]->(m7)

// P4 (Tom Hardy)
CREATE (p4)-[:ACTED_IN]->(m1)
CREATE (p4)-[:ACTED_IN]->(m3)

// Outros
CREATE (p5)-[:DIRECTED]->(m5)
CREATE (p6)-[:ACTED_IN]->(m6)
CREATE (p7)-[:ACTED_IN]->(m7)
CREATE (p8)-[:DIRECTED]->(m8)
CREATE (p9)-[:ACTED_IN]->(m9)
CREATE (p10)-[:ACTED_IN]->(m10)
CREATE (p2)-[:ACTED_IN]->(m8);


// F. GÊNEROS (MEDIA_GENRES)
MATCH (m1:Media {id: 'M1'}), (m2:Media {id: 'M2'}), (m3:Media {id: 'M3'}), (m4:Media {id: 'M4'}), (m5:Media {id: 'M5'}), (m6:Media {id: 'M6'}), (m7:Media {id: 'M7'}), (m8:Media {id: 'M8'}), (m9:Media {id: 'M9'}), (m10:Media {id: 'M10'})
MATCH (g1:Genre {id: 'G1'}), (g2:Genre {id: 'G2'}), (g3:Genre {id: 'G3'}), (g4:Genre {id: 'G4'}), (g5:Genre {id: 'G5'}), (g6:Genre {id: 'G6'}), (g7:Genre {id: 'G7'}), (g8:Genre {id: 'G8'})

CREATE (m1)-[:HAS_GENRE]->(g1), (m1)-[:HAS_GENRE]->(g2), (m1)-[:HAS_GENRE]->(g4)
CREATE (m2)-[:HAS_GENRE]->(g2), (m2)-[:HAS_GENRE]->(g3)
CREATE (m3)-[:HAS_GENRE]->(g5)
CREATE (m4)-[:HAS_GENRE]->(g6), (m4)-[:HAS_GENRE]->(g3)
CREATE (m5)-[:HAS_GENRE]->(g5)
CREATE (m6)-[:HAS_GENRE]->(g2)
CREATE (m7)-[:HAS_GENRE]->(g1), (m7)-[:HAS_GENRE]->(g4)
CREATE (m8)-[:HAS_GENRE]->(g8)
CREATE (m9)-[:HAS_GENRE]->(g3)
CREATE (m10)-[:HAS_GENRE]->(g7);

// G. AVALIAÇÕES (USER_RATINGS)
MATCH (u1:User {id: 'U1'}), (u2:User {id: 'U2'}), (u3:User {id: 'U3'}), (u4:User {id: 'U4'}), (u5:User {id: 'U5'}), (u6:User {id: 'U6'}), (u7:User {id: 'U7'}), (u8:User {id: 'U8'}), (u9:User {id: 'U9'}), (u10:User {id: 'U10'})
MATCH (m1:Media {id: 'M1'}), (m2:Media {id: 'M2'}), (m3:Media {id: 'M3'}), (m4:Media {id: 'M4'}), (m5:Media {id: 'M5'}), (m6:Media {id: 'M6'}), (m7:Media {id: 'M7'}), (m8:Media {id: 'M8'}), (m9:Media {id: 'M9'}), (m10:Media {id: 'M10'})

CREATE (u1)-[:RATED {rating: 5.0}]->(m1)
CREATE (u2)-[:RATED {rating: 4.5}]->(m1)
CREATE (u3)-[:RATED {rating: 4.8}]->(m2)
CREATE (u4)-[:RATED {rating: 3.5}]->(m3)
CREATE (u5)-[:RATED {rating: 4.0}]->(m4)
CREATE (u6)-[:RATED {rating: 5.0}]->(m5)
CREATE (u7)-[:RATED {rating: 4.2}]->(m6)
CREATE (u8)-[:RATED {rating: 4.9}]->(m7)
CREATE (u9)-[:RATED {rating: 3.8}]->(m8)
CREATE (u10)-[:RATED {rating: 4.1}]->(m9);