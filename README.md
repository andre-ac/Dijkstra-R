# Dijkstra-R
Dijkstra's algorithm written in R

# Usage
The graphs are definied by Data Frames with two columns, one named node where each row is a string with a different node and another column named adj with the respective adjacent nodes with their distances separated by commas.

e.g.
```
graph1 <- data.frame(node = c("A","B","C","D"),
                    adj=I(list(c("B,1,C,4"),
                               c("A,1,C,2,D,1"),
                               c("A,4,B,2,D,1"),
                               c("B,1,C,1"))))
```
                            
                           
In order to use the function simply run main.R and call dijkstra(graph) or path(graph,end)

e.g.

dijkstra(graph1) will return the full table will the distances of all nodes to the source ("A")

path(graph1,"C") would return the shortest path from "C" to "A"
