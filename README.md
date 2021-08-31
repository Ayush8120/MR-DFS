# <mark>Improved MR-DFS</mark>

Improved Multi-Robot Depth First Search Algorithm.

Implementation of [This Paper](https://link.springer.com/article/10.1007/s10846-015-0309-9)

### <mark>Abstract:</mark>

-----------

In the task of terrain exploration using multiple robots the present challenges are collission avoidance and declaration of completion. This paper introduces a novel decentralized method for tree/graph exploration with collission avoidance using minimum sensory data and declaration of compeltion of exploration. The paper proposes the use of modified incidence matrix as a data structure for information exchange between robots and the vertex. A robot will drop beacons at every vertex that it travels , to update the incidence matrices and thus convey the message of its edge choices to any subsequent robot that come to that node.

https://user-images.githubusercontent.com/72944387/131514355-1d2561b6-0834-4afe-a7a0-c12d0d0e5d99.mp4


### <mark>Structure Of This Repository</mark>

--------------------

#### <u><mark>[MATLAB Implemetation_ver0] </mark>[Link](https://github.com/Ayush8120/MR-DFS/tree/main/MATLAB%20Implementation_ver0)</u>
-----------------------------------
- Contains code for general topology Algorithm execution
-----------------------------------

#### <u><mark>[MATLAB Implemetation_9_3] </mark>[Link](https://github.com/Ayush8120/MR-DFS/tree/main/MATLAB%20Implementation_9_3)</u>
-----------------------------------
- Contains a particular topology execution; whose video is pinned in README.md
-----------------------------------

#### <u><mark>[Python Implementation] </mark>[Link](https://github.com/Ayush8120/MR-DFS/tree/main/ROS%2BGazebo%20Implementation)</u>
-----------------------------------
- Contains general algorithm execution for any random topology in Python
-----------------------------------

#### <u><mark>[Improved-MR-DFS.pdf] </mark>[Link](https://github.com/Ayush8120/MR-DFS/blob/main/Improved-MR-DFS.pdf)</u>
-----------------------------------
- The implemented paper's pdf version.
-----------------------------------

Run the testing script and enter the number of robots and the number of robots per cluster : Enter 9 and 3

Note : MATLAB Implementation is for only one case , with the following constrants:


  - Number of robots : 9 & Number of Leaf Nodes : 3  

----------
 - Present Implementation done for 9 robots, 3 robot/cluster
 - A more general implementation is available [Here](https://github.com/Ayush8120/MR-DFS/tree/main/ROS%2BGazebo%20Implementation/Python%20Implementation_General)
----------
