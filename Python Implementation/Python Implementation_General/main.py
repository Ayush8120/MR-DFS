
from second_step_on_vertex_visit import second_step_on_vertex_visit
import numpy as np
import pandas as pd
from initialize_graph import Vertex, build_graph, find_shortest_path
from initialize_graph import Robot
from collections import defaultdict
import networkx as nx
import matplotlib.pyplot as plt
from first_step_on_vertex_visit import Id,what_to_do_if_next_node_known,first_step_on_arriving_at_vertex
from get_incidence_matrix import get_incidence_matrix
import pprint
pp = pprint.PrettyPrinter(indent=8)
'''
A standalone implementation of the algorithm on big graph
10 Leaf Nodes
24 Nodes  
'''
#Topography
count = 0 #local flag to declare overall completion 
K = 10 #Number of Leaf nodes = Number of Robots
J = 24 # Number of nodes

vertex = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X"]# Vertex Node name list
edges = ["AC","BC","CD","DE","EF","EK","FG","GH","HI","HJ","KL","KO","LM","LN","OP","PQ","PS","QR","ST","SU","UV","VW","VX"]  # Edge name list
robo_vertex = ["A","B","I","J","M","N","R","T","W","X"] # Spawn Locations of robots
XData = [2.50, 3.50,3,3,3,1.50,1.50,1.50,1,2,3.50,3,2.50,3.50,4.50,4.50,3.50,3.50,5,4.50,5.50,5.50,5,6] #Robot Spawn X cordinates 
YData = [1,1,2,3,4,5,6,7,8,8,5,6,7,7,6,7,8,9,8,9,9,10,11,11]  #Robot Spwn Y cordinates
[graph,edges_decomp] = build_graph(edges)

'''
Graph making for visualization
'''
G = nx.Graph()

for i in range(J):
    G.add_node(chr(i+65))

for ed in edges_decomp:
    print(*ed)
    G.add_edge(*ed)
nx.draw(G,with_labels = True, font_weight = 'bold')
plt.show
# print(G.nodes)
# print(G.edges)

'''
Incidence Matrix Making
'''
incidence_matrix = get_incidence_matrix(XData,YData,G)
pp.pprint(incidence_matrix)

'''
Initializations
'''
#initializing of R : list of Robot objects
R = []
for j in range(K):
    R.append(Robot(j,robo_vertex,incidence_matrix))

#initializing of V : list of Vertex objects
V = []
for j in range(J):
    V.append(Vertex(vertex[j],edges,incidence_matrix))#asdf

'''
CORE ALGORITHM :
Each robot explores until its personal count flag turns ON. And the loop runs till the overall count flag turns ON.
'''
'''
As the robots are placed on leaf nodes thus the vertex will have only one neighbour at that vertex
Thus all the robots are given an initial puch to there immediate neighbors
'''
print("The first mandatory push:")
print('')
for k in range(K):
    
    start = R[k].present_location
    end = V[ord(R[k].present_location) - 65].neighbors[0]
    top = np.array([-1*incidence_matrix[ord(start) - 65,ord(end)-65]])
    bottom = np.array([-1*incidence_matrix[ord(end) - 65,ord(start)-65]])
    col_vector = np.vstack((top,bottom))    
    
    R[k].path.append('Base Station') # hovering over the launchpad
    R[k].path.append(R[k].present_location) # leaf node name designated
    R[k].path.append(V[ord(R[k].present_location) - 65].neighbors[0]) 
    print("The {e} robot is currently at {f}".format(e=k,f=R[k].present_location))
    print("The next node chosen is {}".format(V[ord(R[k].present_location) - 65].neighbors[0]))
    
    id,R,V = what_to_do_if_next_node_known(R,k,V,1,R[k].present_location,V[ord(R[k].present_location) - 65].neighbors[0],incidence_matrix=incidence_matrix)
    R[k].next_edge_decided,count = second_step_on_vertex_visit(graph, V,R,k,count)
    print('The next edge selected by - ' + str(k) + '- robot is' + str(R[k].next_edge_decided))
    print('')
   
print("This is the loop part which continues till the declaration of completion")
while(count != K):
     for z in range(K):
         if R[z].count != 1:
            print("{z} robot Travelling to the selected edge :{e}".format(z = z , e = R[z].next_edge_decided) )
            R[z].path.append(R[z].next_edge_decided.replace(R[z].present_location,''))
            if R[z].next_edge_decided !=0:
               id,R,V = what_to_do_if_next_node_known(R,z,V,2,R[z].present_location, R[z].next_edge_decided.replace(R[z].present_location,''),incidence_matrix = incidence_matrix)
               R[z].next_edge_decided,count = second_step_on_vertex_visit(graph, V,R,z,count)
               if R[z].next_edge_decided != 0:
                    print('The next edge selected by : ' + str(z) + ' : robot is :' + str(R[z].next_edge_decided))
                    print('')
'''
To get an overall view of the setpoints decided for each robot
'''
for k in range(K):
    R[k].path.append('Base Station')
    print("Setpoint list of : " +str(k) + " robot is : " )
    print((R[k].path))