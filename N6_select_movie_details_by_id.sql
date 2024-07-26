SELECT
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    json_build_object('id', f.id, 'file_name', f.file_name, 'mime_type', f.mime_type, 'url', f.url) AS poster,
    json_build_object('id', d.id, 'first_name', d.first_name, 'last_name', d.last_name, 'photo', json_build_object('id', pf.id, 'file_name', pf.file_name, 'mime_type', pf.mime_type, 'url', pf.url)) AS director,
    json_agg(json_build_object('id', p.id, 'first_name', p.first_name, 'last_name', p.last_name, 'photo', json_build_object('id', pp.id, 'file_name', pp.file_name, 'mime_type', pp.mime_type, 'url', pp.url))) AS actors,
    json_agg(json_build_object('id', g.id, 'name', g.name)) AS genres
FROM
    movie m
LEFT JOIN
    file f ON m.poster_file_id = f.id
JOIN
    person d ON m.director_id = d.id
LEFT JOIN
    file pf ON d.primary_photo_id = pf.id
JOIN
    "character" c ON m.id = c.movie_id
JOIN
    person p ON c.person_id = p.id
LEFT JOIN
    file pp ON p.primary_photo_id = pp.id
JOIN
    movie_genre mg ON m.id = mg.movie_id
JOIN
    genre g ON mg.genre_id = g.id
WHERE
    m.id = 1
GROUP BY
    m.id, f.id, d.id, pf.id;
