using DataFramesMeta, DataFrames, CSV, Statistics

df_diamonds = CSV.File("diamonds.csv", header = 1, delim = ",") |> DataFrame

@linq df_diamonds |>
    select(:price, :color) |>
    by(:color, 
        avg_price = mean(:price), 
        high_end = mean(:price) > 5000 ? 1 : 0)
