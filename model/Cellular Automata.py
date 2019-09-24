"""
=============
  元胞自动机
=============
"""

import numpy as np
import matplotlib.pyplot as plt

# 空间大小
number = 200

# 细胞分布(在初始位置状态设为1)
cells = np.zeros((number, number))
cells[int(number/2)][int(number/2)-1] = 1
cells[int(number/2)][int(number/2)] = 1
cells[int(number/2)][int(number/2)+1] = 1


# 绘图(初始情况的图)
def paintCells(cells):
    x = []
    y = []
    length = len(cells)
    for i in range(length):
        for j in range(length):
            if cells[i][j] == 1:
                x.append(i)
                y.append(j)
    plt.xlim((0, length))
    plt.ylim((0, length))
    plt.plot(x, y, '.')
    plt.show()
    plt.cla()


# 统计，在范围内有多少个状态为1的细胞
def countCells(cells, i, j):
    count = 0
    for m in range(i-1, i+2):
        for n in range(j-1, j+2):
            if cells[m][n] == 1:
                count += 1
    return count


# 更新
def updateCells(cells):
    length = len(cells)
    ncells = np.zeros((length, length))
    for i in range(1, length-1):
        for j in range(1, length-1):
            count = countCells(cells, i, j)
            if count == 2 or count == 3:
                ncells[i][j] = 1
    return ncells


paintCells(cells)
for _ in range(80):
    cells = updateCells(cells)
paintCells(cells)
