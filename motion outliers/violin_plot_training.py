# -*- coding: utf-8 -*-


import seaborn as sns
import matplotlib.pyplot as plt
df = sns.load_dataset('tips')
df.head()
ax=sns.violinplot(data=df, x='day',y='tip', palette='pastel')
ax=sns.stripplot(data=df, x='day', y='tip', color='black', alpha=0.5)
ax.set(
       title='i am having fun',
       xlabel='Weekday',
       ylabel='Tip Amount'
       )
plt.show()