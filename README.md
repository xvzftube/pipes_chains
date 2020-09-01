# The opinionated way to manipulate dataframes
---

The point is that data manipulation is better when it is more human readable. 

This repo contains code and data to show how to use chaining in sqlite, julia, R, and Python. I did not have to stop there. I could have also shown how this works in Scala/Spark and other dialects of SQL. This is just enough to present the ideas in enough variety so you can apply the idea in environment which may be different from the ones I have shown.

### Julia

```julia
using DataFramesMeta, DataFrames, CSV, Statistics

df_diamonds = CSV.File("diamonds.csv", header = 1, delim = ",") |> DataFrame

@linq df_diamonds |>
    select(:price, :color) |>
    by(:color, 
        avg_price = mean(:price), 
        high_end = mean(:price) > 5000 ? 1 : 0)
```

### Python

```python
import numpy as np
import pandas as pd

df_diamonds = pd.read_csv("diamonds.csv")

(df_diamonds
    .loc[:, ('color', 'price')]
    .groupby(by=['color'], as_index=False)
    .mean()
    .assign(high_end=lambda df: np.where(df.price > 5000, 1, 0)))
```

### R

```r
library(dplyr)

df_diamonds <- read.csv("diamonds.csv")

df_diamonds %>%
  select(color, price) %>%
  group_by(color) %>%
  summarize(avg_price = mean(price)) %>%
  mutate(high_end = ifelse(avg_price > 5000, 1, 0))
```

### Sqlite

```sqlite
-- import data and print pretty columns
.import diamonds.csv Diamonds
.mode column

-- basic sqlite3 commands
select color, price from Diamonds limit 10;

-- CTE: group by statements
with a as(
  select 
  color 
  ,avg(price) as avg_price 
  from Diamonds 
  group by color
)
select * from a;

-- CTE 2: group by statements
with a as(
  select color
  ,avg(price) as avg_price 
  from Diamonds 
  group by color
),
b as(
  select 
  color 
  ,avg_price  
  ,case when avg_price >= 4000 then 1 else 0 end as high_end
  from a
)
select * from b;
```
