# <mark>Improved MR-DFS</mark>

Improved Multi-Robot Depth First Search Algorithm.

Implementation of [This Paper](https://link.springer.com/article/10.1007/s10846-015-0309-9)

### <mark>Abstract:</mark>

-----------

In the task of terrain exploration using multiple robots the present challenges are collission avoidance and declaration of completion. This paper introduces a novel decentralized method for tree/graph exploration with collission avoidance using minimum sensory data and declaration of compeltion of exploration. The paper proposes the use of modified incidence matrix as a data structure for information exchange between robots and the vertex. A robot will drop beacons at every vertex that it travels , to update the incidence matrices and thus convey the message of its edge choices to any subsequent robot that come to that node.

https://user-images.githubusercontent.com/72944387/131514355-1d2561b6-0834-4afe-a7a0-c12d0d0e5d99.mp4


### <mark>Structure Of This Repository</mark>

--------------------

#### <u><mark>[MATLAB Implemetation] </mark>(Add Link)                                                          </u>

> Images-Videos
> 
>     - Video of Exploration
> 
>     -Image of the graph chosen
> 
> scripts
> 
>     -first_step_on_vertex_visit.m(add link)
> 
>     -get_incidence_matrix.m(add link)
> 
>     -initialize_graph.m(add link)
> 
>     -merge_matrices.m(add link)
> 
>     -order_matrix.m(add link)
> 
>     -second_step_on_vertex_visit.m(add link)
> 
>     -testingscript.m(add link)

Run the testing script and enter the number of robots and the number of robots per cluster.

[link to video in the MATLAB Implementation file ]()

Note : MATLAB Implementation is for only one case , with the following constrants:

>    - Number of robots = Number of Leaf Nodes  
> 
> ------------------------
> 
> <img title="" src="https://lh4.googleusercontent.com/NbC7_dgf-JYXHwEj6-fSv7HI0IUtikwHSwkhjqhVZi_tB7cax2JyrX66AWdmOx1fj-EzSSDkPIFgrRkBb6vX2xmF0McxO1phlTKeJZQM2FVzYb7XPtd00REUeZytWTYyG7qF-VjB" alt="" width="299" data-align="center">
> 
> ----------------
> 
>  - Present Implementation done for 9 robots, 3 robot/cluster
