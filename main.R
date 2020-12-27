
graph1 <- data.frame(node = c("A","B","C","D"),
                    adj=I(list(c("B,1,C,4"),
                               c("A,1,C,2,D,1"),
                               c("A,4,B,2,D,1"),
                               c("B,1,C,1"))))

graph2 <- data.frame(node = c("A","B","C","D","E","F"),
                    adj=I(list(c("B,2,C,1,D,1"),
                               c("A,2,D,2,F,1"),
                               c("A,1,E,3"),
                               c("A,1,B,2,C,1,E,1"),
                               c("C,3,D,1,F,3"),
                               c("B,1,F,3"))))

graph3 <- data.frame(node = c("A","B","C","D","E","F","G","H"),
                     adj=I(list(c("B,1,C,4,E,6"),
                                c("A,1,C,2,D,1,G,6"),
                                c("A,4,B,2,D,1,F,2,E,1"),
                                c("B,1,C,1,F,2"),
                                c("A,6,C,1,H,5"),
                                c("C,2,D,2,G,3"),
                                c("B,6,F,3,H,7"),
                                c("E,5,G,7"))))


dijkstra <- function(graph){

  dist <- data.frame(node = graph$node,
                     shortest_dist = Inf,
                     prev_node = NA)
  
  dist$shortest_dist[graph$node == "A"] <- 0

  unvisited <- list(graph$node)[[1]]
  
  adj_A_list <- as.list(strsplit(graph$adj[graph$node=="A"][[1]],","))[[1]]
  adj_A <- intersect(graph$node,adj_A_list)
  adj_A_distance <- adj_A_list[!(adj_A_list %in% adj_A)]

  for (count in 1:length(adj_A)){
    
      dist$shortest_dist[dist$node == adj_A[count]] <- as.integer(adj_A_distance[count])
      dist$prev_node[dist$node == adj_A[count]] <- "A"
    }
  
  unvisited <- unvisited[ unvisited != "A"]

  while (length(unvisited) != 0){
    
    current_min_dist_un <- min(dist$shortest_dist[which(dist$node %in% unvisited)])
    
    lowest_node <- dist$node[dist$shortest_dist == current_min_dist_un]
    lowest_node <- lowest_node[lowest_node %in% unvisited][1]
    
    adj_list <- as.list(strsplit(graph$adj[graph$node==lowest_node][[1]],","))[[1]]
    adj_nodes <- intersect(graph$node,adj_list)
    adj_distance <- adj_list[!(adj_list %in% adj_nodes)]
    
    for (count in 1:length(adj_nodes)){
      
      old_dist <- dist$shortest_dist[dist$node==adj_nodes[count]]
      new_dist <- as.integer(adj_distance[count]) + as.integer(dist$shortest_dist[dist$node==lowest_node])

      if(new_dist < old_dist){
        dist$shortest_dist[dist$node == adj_nodes[count]] <- as.integer(new_dist)
        dist$prev_node[dist$node == adj_nodes[count]] <- lowest_node
      }
    }

    unvisited <- unvisited[ unvisited != lowest_node]
  }
  return(dist)
}

path <- function(graph, end){
  dist <- dijkstra(graph)
  last_node <- end
  end_path <- c()
  while (is.na(last_node)==FALSE){
    end_path <- c(end_path,last_node)
    last_node <- dist$prev_node[dist$node == last_node]
  }
  cat(end_path,sep=">")
}


