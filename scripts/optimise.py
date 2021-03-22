#!/bin/python

import os
import numpy as np
import matplotlib.pyplot as plt
import oapackage

data = np.random.rand(4, 50)

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
  

#def find_pareto(points):
#  pareto=oapackage.ParetoDoubleLong()
#  for ii in range(0, points.shape[1]):
#    w=oapackage.doubleVector( (points[0,ii], points[1,ii]) )
#    pareto.addvalue(w, ii)
#
#  pareto.show(verbose=1)
#  # Plot results
#  lst=pareto.allindices() # the indices of the Pareto optimal designs
#
#  optimal_points=points[:,lst]
#
#  h=plt.plot(points[0,:], points[1,:], '.b', markersize=16, label='Non Pareto-optimal')
#  hp=plt.plot(optimal_points[0,:], optimal_points[1,:], '.r', markersize=16, label='Pareto optimal')
#  plt.xlabel('Objective 1', fontsize=16)
#  plt.ylabel('Objective 2', fontsize=16)
#  plt.xticks([])
#  plt.yticks([])
#  _=plt.legend(loc=3, numpoints=1)

points = find_pareto(data)
print(points)


#plt.show()
