select
    songs.song_title,
    count(*) as total_plays,
    count(*) filter(
        where
            user_plays.duration is null
            or (user_plays.duration < songs.song_duration)
    ) as total_skips
from
    user_plays
    join songs using(song_id)
group by songs.song_id
order by total_plays desc, total_skips asc
limit 1
