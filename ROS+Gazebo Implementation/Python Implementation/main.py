#!/usr/bin/env python2
#***************************************************************************
#
#   Copyright (c) 2015 PX4 Development Team. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. Neither the name PX4 nor the names of its contributors may be
#    used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
#***************************************************************************/

#
# @author Andreas Antener <andreas@uaventure.com>
#
# The shebang of this file is currently Python2 because some
# dependencies such as pymavlink don't play well with Python3 yet.



# from __future__ import division

# PKG = 'px4'

# import rospy
# import math
# import numpy as np
# from geometry_msgs.msg import PoseStamped, Quaternion
# from mavros_test_common import MavrosTestCommon
# from pymavlink import mavutil
# from six.moves import xrange
# from std_msgs.msg import Header
# from threading import Thread
# from tf.transformations import quaternion_from_euler


# class MavrosOffboardPosctlTest(MavrosTestCommon):
#     """
#     Tests flying a path in offboard control by sending position setpoints
#     via MAVROS.
#     For the test to be successful it needs to reach all setpoints in a certain time.
#     FIXME: add flight path assertion (needs transformation from ROS frame to NED)
#     """

#     def setUp(self):
#         super(MavrosOffboardPosctlTest, self).setUp()

#         self.pos = PoseStamped()
#         self.radius = 1

#         self.pos_setpoint_pub = rospy.Publisher(
#             'mavros/setpoint_position/local', PoseStamped, queue_size=1)

#         # send setpoints in seperate thread to better prevent failsafe
#         self.pos_thread = Thread(target=self.send_pos, args=())
#         self.pos_thread.daemon = True
#         self.pos_thread.start()

#     def tearDown(self):
#         super(MavrosOffboardPosctlTest, self).tearDown()

#     #
#     # Helper methods
#     #
#     def send_pos(self):
#         rate = rospy.Rate(10)  # Hz
#         self.pos.header = Header()
#         self.pos.header.frame_id = "base_footprint"

#         while not rospy.is_shutdown():
#             self.pos.header.stamp = rospy.Time.now()
#             self.pos_setpoint_pub.publish(self.pos)
#             try:  # prevent garbage in console output when thread is killed
#                 rate.sleep()
#             except rospy.ROSInterruptException:
#                 pass

#     def is_at_position(self, x, y, z, offset):
#         """offset: meters"""
#         rospy.logdebug(
#             "current position | x:{0:.2f}, y:{1:.2f}, z:{2:.2f}".format(
#                 self.local_position.pose.position.x, self.local_position.pose.
#                 position.y, self.local_position.pose.position.z))

#         desired = np.array((x, y, z))
#         pos = np.array((self.local_position.pose.position.x,
#                         self.local_position.pose.position.y,
#                         self.local_position.pose.position.z))
#         return np.linalg.norm(desired - pos) < offset

#     def reach_position(self, x, y, z, timeout):
#         """timeout(int): seconds"""
#         # set a position setpoint
#         self.pos.pose.position.x = x
#         self.pos.pose.position.y = y
#         self.pos.pose.position.z = z
#         rospy.loginfo(
#             "attempting to reach position | x: {0}, y: {1}, z: {2} | current position x: {3:.2f}, y: {4:.2f}, z: {5:.2f}".
#             format(x, y, z, self.local_position.pose.position.x,
#                    self.local_position.pose.position.y,
#                    self.local_position.pose.position.z))

#         # For demo purposes we will lock yaw/heading to north.
#         yaw_degrees = 0  # North
#         yaw = math.radians(yaw_degrees)
#         quaternion = quaternion_from_euler(0, 0, yaw)
#         self.pos.pose.orientation = Quaternion(*quaternion)

#         # does it reach the position in 'timeout' seconds?
#         loop_freq = 2  # Hz
#         rate = rospy.Rate(loop_freq)
#         reached = False
#         for i in xrange(timeout * loop_freq):
#             if self.is_at_position(self.pos.pose.position.x,
#                                    self.pos.pose.position.y,
#                                    self.pos.pose.position.z, self.radius):
#                 rospy.loginfo("position reached | seconds: {0} of {1}".format(
#                     i / loop_freq, timeout))
#                 reached = True
#                 break

#             try:
#                 rate.sleep()
#             except rospy.ROSException as e:
#                 self.fail(e)

#         self.assertTrue(reached, (
#             "took too long to get to position | current position x: {0:.2f}, y: {1:.2f}, z: {2:.2f} | timeout(seconds): {3}".
#             format(self.local_position.pose.position.x,
#                    self.local_position.pose.position.y,
#                    self.local_position.pose.position.z, timeout)))

#     #
#     # Test method
#     #
#     def test_posctl(self):
#         """Test offboard position control"""

#         # make sure the simulation is ready to start the mission
#         self.wait_for_topics(60)
#         self.wait_for_landed_state(mavutil.mavlink.MAV_LANDED_STATE_ON_GROUND,
#                                    10, -1)

#         self.log_topic_vars()
#         self.set_mode("OFFBOARD", 5)
#         self.set_arm(True, 5)

#         rospy.loginfo("run mission")
#         positions = ((0, 0, 0), (50, 50, 20), (50, -50, 20), (-50, -50, 20),
#                      (0, 0, 20))

#         for i in xrange(len(positions)):
#             self.reach_position(positions[i][0], positions[i][1],
#                                 positions[i][2], 30)

#         self.set_mode("AUTO.LAND", 5)
#         self.wait_for_landed_state(mavutil.mavlink.MAV_LANDED_STATE_ON_GROUND,
#                                    45, 0)
#         self.set_arm(False, 5)


# if __name__ == '__main__':
#     import rostest
#     rospy.init_node('test_node', anonymous=True)

#     rostest.rosrun(PKG, 'mavros_offboard_posctl_test',
#                    MavrosOffboardPosctlTest)




###########------------MY CODE-----------############3

from second_step_on_vertex_visit import second_step_on_vertex_visit
import numpy as np
from initialize_graph import Vertex, build_graph, find_shortest_path
from initialize_graph import Robot
from collections import defaultdict
import networkx as nx
import matplotlib.pyplot as plt
from first_step_on_vertex_visit import Id,what_to_do_if_next_node_known,first_step_on_arriving_at_vertex
from get_incidence_matrix import get_incidence_matrix
import pprint
pp = pprint.PrettyPrinter(indent=8)
#Topography 
K = 4
J = 8
count = 0
edges = ["AB","BC","CD","CE","AF","AH","GH"] # change this when implementing for a different topo
vertex = ["A","B","C","D","E","F","G","H"] # change this when implementing for a different topo
robo_vertex = ["D","E","F","G"]
XData = [2.5000, 1.5000, 1.5000, 1, 2, 2.5000, 3.5000, 3.5000]
YData = [4, 3, 2, 1, 1, 3, 2, 3]
[graph,edges_decomp] = build_graph(edges)

G = nx.Graph()

for i in range(J):
    G.add_node(chr(i+65))
    #print('LAMBA')

for ed in edges_decomp:
    print(*ed)
    G.add_edge(*ed)
nx.draw(G,with_labels = True, font_weight = 'bold')
#plt.subplot(111)
plt.show
print(G.nodes)
print(G.edges)
#---------------------------------------------------------------------------
incidence_matrix = get_incidence_matrix(XData,YData,G)
pp.pprint(incidence_matrix)
#J = input("Enter the number of nodes: ")
#K = input("Enter the number of robots: ")
#K = int(K)
#J = int(J)
#----------------------------------------------------------------------------
#leaf = np.zeros((1,int(K),numpy.s))
#leaf = []s
#for i in range(int(K)):
#    leaf.append(input("Node Name of {i} th robot"))
#print(leaf) #list of node names where robots are placed

#---------------------------------------------------------------------------
#incidence_matrix = np.zeros((J,J))
#get the cordinates and map them to vertex alphabet
#build the matrix accordingly
#incidence_matrix = np.ones((J,J))

#initializing of R : list of Robot objects
R = []
for j in range(K):
    R.append(Robot(j,robo_vertex,incidence_matrix))

#initializing of V : list of Vertex objects
V = []
for j in range(J):
    V.append(Vertex(vertex[j],edges,incidence_matrix))#asdf

#print(R[2].__dict__) # prints all attributes
#print(V[2].__dict__) # prints all attributes

#--------------------------------------------------------------------------
# graph = build_graph(edges)
# edge_path = []
# node_path = find_shortest_path(graph,'A','D')

# for i in range(len(node_path) -1):
#     edge_path.append(node_path[i] + node_path[i+1])
# print(edge_path)

#--------------------------------------------------------------------------

#As the robots are placed on leaf nodes thus the vertex will have only one neighbour at that vertex
#All the rbos are given an initial puch to there immediate neighbors
print("The first mandatory push:")
print('')
for k in range(K):
    #print(R[k].present_location)
    start = R[k].present_location
    #print(V[ord(R[k].present_location) - 65].neighbors[0])
    end = V[ord(R[k].present_location) - 65].neighbors[0]
    #print(-1*incidence_matrix[ord(start) - 65,ord(end)-65])
    top = np.array([-1*incidence_matrix[ord(start) - 65,ord(end)-65]])
    bottom = np.array([-1*incidence_matrix[ord(end) - 65,ord(start)-65]])
    col_vector = np.vstack((top,bottom))
    #print(col_vector)
    #print(np.shape(col_vector))
    #print(bottom)    
    
    #print(np.vstack((top,bottom))) 
    print("The {e} robot is currently at {f}".format(e=k,f=R[k].present_location))
    print("The next node chosen is {}".format(V[ord(R[k].present_location) - 65].neighbors[0]))
    id,R,V = what_to_do_if_next_node_known(R,k,V,1,R[k].present_location,V[ord(R[k].present_location) - 65].neighbors[0],incidence_matrix=incidence_matrix)
    #print(V[ord(R[k].present_location) - 65].__dict__)
    #print(R[k].__dict__)
    R[k].next_edge_decided,count = second_step_on_vertex_visit(graph, V,R,k,count)
    print('The next edge selected by - ' + str(k) + '- robot is' + str(R[k].next_edge_decided))
    print('')
    #publish the setpoint of the node to this drone command
    #id,R,V = what_to_do_if_next_node_known(R,k,V,2,R[k].present_location, R[k].next_edge_decided.replace(R[k].present_location,''),incidence_matrix = incidence_matrix)
    #print(R[k].present_location)
print("This is the loop part which continues till the declaration of completion")
while(count != K):
     for z in range(K):
         if R[z].count != 1:
            print("{z} robot Travelling to the selected edge :{e}".format(z = z , e = R[z].next_edge_decided) )
            if R[z].next_edge_decided !=0:
               id,R,V = what_to_do_if_next_node_known(R,z,V,2,R[z].present_location, R[z].next_edge_decided.replace(R[z].present_location,''),incidence_matrix = incidence_matrix)
               R[z].next_edge_decided,count = second_step_on_vertex_visit(graph, V,R,z,count)
               print('The next edge selected by : ' + str(z) + ' : robot is :' + str(R[z].next_edge_decided))
               print('')