import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt 

from sklearn import model_selection     #分离数据
from sklearn.linear_model import LogisticRegression     #对率回归
from sklearn import metrics     #评估

#读取数据
dataset = pd.read_csv('D:\硕士学习\Algorithm\Watermelon\watermelon3.0.csv')

X = dataset[['密度','含糖率']]
Y = dataset['好瓜']

plt.title('watermelon3.3')
plt.xlabel('density')
plt.ylabel('ratio_sugar')
plt.xlim(0,1)
plt.ylim(0,0.5)
#绘制散点图
plt.scatter([0.666,0.243,0.245,0.343,0.639,0.657,0.360,0.593,0.719],[0.091,0.267,0.057,0.099,0.161,0.198,0.370,0.042,0.103], marker = 'o', color = 'r', s=100, label = 'Badmelon')
plt.scatter([0.697,0.774,0.634,0.608,0.556,0.430,0.481,0.437], [0.460,0.376,0.264,0.318,0.215,0.237,0.149,0.211], marker = 'o', color = 'g', s=100, label = 'Goodmelon')
plt.legend(loc = 'upper right')     #用于显示图例

#分割数据集
X_train,X_test,Y_train,Y_test = model_selection.train_test_split(X,Y,test_size=0.5,random_state=0)

#训练
log_model=LogisticRegression()
log_model.fit(X_train,Y_train)
#验证
Y_pred=log_model.predict(X_test)
#输出
print(Y_test,Y_pred)
# print(metrics.confusion_matrix(Y_test,Y_pred))    #混淆矩阵评估分类器准确性
print(log_model.coef_)      #b,k两个参数
b, k = log_model.coef_[0][0], log_model.coef_[0][1]
X_pred = np.linspace(0,1,100)
line_pred = b + k * X_pred
plt.plot(X_pred, line_pred)
plt.show()