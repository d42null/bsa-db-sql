SELECT
    p.id,
    p.first_name,
    p.last_name,
    SUM(m.budget) AS total_movies_budget
FROM
    person p
JOIN
    "character" c ON p.id = c.person_id
JOIN
    movie m ON c.movie_id = m.id
GROUP BY
    p.id, p.first_name, p.last_name;
