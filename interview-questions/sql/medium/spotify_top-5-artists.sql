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
        COUNT(*) AS times_in_top_ten
    FROM global_song_rank
    WHERE rank <= 10
    GROUP BY song_id
),
artist_totals AS (
    SELECT 
        a.artist_name,
        SUM(t.times_in_top_ten) AS total_times_in_top_ten
    FROM global_top_ten t 
    JOIN songs s 
        ON t.song_id = s.song_id
    JOIN artists a 
        ON s.artist_id = a.artist_id
    GROUP BY a.artist_name
),
artist_ranked AS (
    SELECT
        artist_name,
        DENSE_RANK() OVER (
            ORDER BY total_times_in_top_ten DESC
        ) AS artist_rank
    FROM artist_totals
)

SELECT *
FROM artist_ranked
WHERE artist_rank <= 5
ORDER BY artist_rank;