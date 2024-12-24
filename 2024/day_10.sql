select date
from drinks
group by date
having
    sum(quantity) filter(where drink_name = 'Peppermint Schnapps') = 298
    and sum(quantity) filter(where drink_name = 'Hot Cocoa') = 38
    and sum(quantity) filter(where drink_name = 'Eggnog') = 198
