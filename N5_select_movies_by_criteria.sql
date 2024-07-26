SELECT
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    json_build_object('id', f.id, 'file_name', f.file_name, 'mime_type', f.mime_type, 'url', f.url) AS poster,
    json_build_object('id', d.id, 'first_name', d.first_name, 'last_name', d.last_name) AS director
FROM
    movie m
JOIN
    country c ON m.country_id = c.id
LEFT JOIN
    file f ON m.poster_file_id = f.id
JOIN
    person d ON m.director_id = d.id
JOIN
    movie_genre mg ON m.id = mg.movie_id
JOIN
    genre g ON mg.genre_id = g.id
WHERE
    m.country_id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration > '2 hours 15 minutes'
    AND (g.name = 'Action' OR g.name = 'Drama')
GROUP BY
    m.id, f.id, d.id;
