import numpy as np
import pandas as pd

df_diamonds = pd.read_csv("diamonds.csv")

(df_diamonds
    .loc[:, ('color', 'price')]
    .groupby(by=['color'], as_index=False)
    .mean()
    .assign(high_end=lambda df: np.where(df.price > 5000, 1, 0)))
