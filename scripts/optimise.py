#!/bin/python

import os
import numpy as np
import matplotlib.pyplot as plt

data = np.array(np.random.rand(50, 3))

def find_pareto(points):
  points = points[points.sum(1).argsort()[::1]]
  undominated = np.ones(points.shape[0], dtype=bool)

  for i in range(points.shape[0]):
    n = points.shape[0]

    if i >= n: 
      break

    undominated[i+1:n] = (points[i+1:] >= points[i]).any(1)
    points = points[undominated[:n]]

  return points

def print2D(points, data):
  plt.plot(data[0,:], data[1,:], '.b', markersize=16, label= 'Data Set')
  plt.plot(points[0,:], points[1,:], '.r', markersize=16, label= 'Pareto Optimal')
  plt.xlabel('OBJ 1', fontsize=16)
  plt.ylabel('OBJ 2', fontsize=16)
  plt.xticks([])
  plt.yticks([])
  _=plt.legend(loc=3, numpoints=1)

  plt.show()


def print3D(points):
  fig = plt.figure()
  ax = fig.add_subplot(111, projection='3d')

  x = points[:,0]
  y = points[:,1]
  z = points[:,2] * 50

  ax.scatter(x,y,z)

  ax.set_xlabel('OBJ 1', fontsize=16)
  ax.set_ylabel('OBJ 2', fontsize=16)
  ax.set_zlabel('OBJ 3', fontsize=16)

  plt.show()

points = find_pareto(data)
print(points)

print3D(points)
