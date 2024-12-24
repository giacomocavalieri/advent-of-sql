select areas.place_name
from
    sleigh_locations
    join areas on
        st_intersects(areas.polygon, sleigh_locations.coordinate)
