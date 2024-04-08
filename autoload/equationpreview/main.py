import matplotlib.pyplot as plt
dpi = plt.rcParams['figure.dpi']

eq_list = %s
width = %d
color = '%s'
fontsize = %d  # pt
L = len(eq_list)
h = fontsize/72.0*L*2.0+0.2  # inch

w = float(width)/dpi  # inch
fig = plt.figure(figsize=(w, h))
ax1 = fig.add_axes([0.0, 0.0, 1.0, 1.0])
for i, eq_str in enumerate(eq_list):
    ax1.text(0.2, 0.1+(1.0/L*(L-1-i)), r'${}$'.format(eq_str),
             fontdict=dict(color=color, fontsize=fontsize,
                           va='bottom', ha='left'))
ax1.grid(False)
plt.show()
