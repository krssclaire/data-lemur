/*
Assume there are three Spotify tables: 
- artists
- songs
- global_song_rank
which contain information about the artists, songs, and music charts, 
respectively.

Write a query to find the top 5 artists whose songs appear most frequently 
in the Top 10 of the global_song_rank table. 
Display the top 5 artist names in ascending order, along with their song
appearance ranking.

If two or more artists have the same number of song appearances, they 
should be assigned the same ranking, and the rank numbers should be 
continuous (i.e. 1, 2, 2, 3, 4, 5). 
*/
WITH global_top_ten AS (
    SELECT
        song_id,
        COUNT(song_id) AS times_in_top_ten
    FROM global_song_rank
    WHERE rank <= 10
    GROUP BY song_id
    ORDER BY 2 DESC
)

SELECT 
    t.song_id,
    t.times_in_top_ten,
    a.artist_name,
    D OVER(
        PARTITION BY artist_name
        ORDER BY 
    )
FROM global_top_ten t 
JOIN songs s 
    ON t.song_id = s.song_id
JOIN artists a 
    ON s.artist_id = a.artist_id
GROUP BY a.artist_name
ORDER BY t.times_in_top_ten DESC

---
WITH global_top_ten AS (
    SELECT
        song_id,
        COUNT(song_id) 
        SUM(COUNT(song_id)) OVER(
            PARTITION 
        ) AS times_in_top_ten
    FROM global_song_rank
    WHERE rank <= 10
    GROUP BY song_id
    ORDER BY 2 DESC
)

SELECT 
    a.artist_name,
    t.times_in_top_ten,
    SUM(t.times_in_top_ten) OVER(
        PARTITION BY a.artist_name
        ORDER BY t.times_in_top_ten
    )
FROM global_top_ten t 
JOIN songs s 
    ON t.song_id = s.song_id
JOIN artists a 
    ON s.artist_id = a.artist_id
GROUP BY a.artist_name, 2

----
WITH global_top_ten AS (
    SELECT
        song_id,
        COUNT(song_id) AS times_in_top_ten
    FROM global_song_rank
    WHERE rank <= 10
    GROUP BY song_id
    ORDER BY 2 DESC
)

SELECT 
    a.artist_name,
    t.times_in_top_ten,
    SUM(t.times_in_top_ten) OVER(
        PARTITION BY a.artist_name
        ORDER BY t.times_in_top_ten
    )
FROM global_top_ten t 
JOIN songs s 
    ON t.song_id = s.song_id
JOIN artists a 
    ON s.artist_id = a.artist_id
GROUP BY a.artist_name, 2
ORDER BY 3 DESC
LIMIT 5