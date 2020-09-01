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

