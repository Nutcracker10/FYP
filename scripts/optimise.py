#!/bin/python

import os
import numpy as np
import matplotlib.pyplot as plt

#data = np.array(np.random.rand(50, 3))
data = np.genfromtxt('./results/test_results.csv', delimiter=',')

def find_pareto(data):
  points = data[data.sum(1).argsort()[::1]]
  undominated = np.ones(points.shape[0], dtype=bool)

  for i in range(points.shape[0]):
    n = points.shape[0]

    if i >= n: 
      break

    undominated[i+1:n] = (points[i+1:] >= points[i]).any(1)
    points = points[undominated[:n]]

  return points

def print2D(points, data):
  #plt.plot(data[0,:], data[1,:], '.b', markersize=16, label= 'Data Set')
  #plt.plot(points[0,:], points[1,:], '.r', markersize=16, label= 'Pareto Optimal')

  plt.scatter(points[:,0], points[:,1], c='r')
  plt.scatter(data[:,0], points[:,1], c='b')
  plt.xlabel('OBJ 1', fontsize=16)
  plt.ylabel('OBJ 2', fontsize=16)
  plt.xticks([])
  plt.yticks([])

  #plt.show()

  plt.savefig('./results/result.png')


def print3D(points, data):
  fig = plt.figure()
  ax = fig.add_subplot(111, projection='3d')

  x = points[:,0]
  y = points[:,1]
  z = points[:,2] * 50

  x1 = data[:,0]
  y1 = data[:,1]
  z1 = data[:,2] * 50
  
  ax.scatter(x,y,z, c='r')
  ax.scatter(x1,y1,z1, c='b')

  ax.set_xlabel('OBJ 1', fontsize=16)
  ax.set_ylabel('OBJ 2', fontsize=16)
  ax.set_zlabel('OBJ 3', fontsize=16)

  #plt.show()
  plt.savefig('./results/result.png')

points = find_pareto(data)

if (points.shape[1] == 2):
  print2D(points, data)
elif (points.shape[1] == 3):
  print3D(points, data)
else :
  print(points)

np.savetxt("./results/optimal_result.csv", points, delimiter=",")
