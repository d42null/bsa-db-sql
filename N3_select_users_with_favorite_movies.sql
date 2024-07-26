SELECT
    u.id,
    u.username,
    ARRAY_AGG(fm.movie_id) AS favorite_movie_ids
FROM
    "user" u
LEFT JOIN
    favorite_movies fm ON u.id = fm.user_id
GROUP BY
    u.id, u.username;
