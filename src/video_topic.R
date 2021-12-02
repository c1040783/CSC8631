#keep related columns or variables to the observation
#step position, title, total_views and viewed_onehundred_percent
video3 <- video3[c(1:2, 4, 15)]
video4 <- video4[c(1:2, 4, 15)]
video5 <- video5[c(1:2, 4, 15)]
video6 <- video6[c(1:2, 4, 15)]
video7 <- video7[c(1:2, 4, 15)]

#index and bind the data to enable easier graphing 
video3['run'] <- 3; video4['run'] <- 4; 
video5['run'] <- 5; video6['run'] <- 6;
video7['run'] <- 7

merged_video <- do.call("rbind", list(video3, video4, video5, 
                                        video6, video7))

#change step_position format from numeric to string for x axis 
#graphing
merged_video$step_position <- as.character(merged_video$step_position)

#plot the percentage of viewed one hundred percent (complete) 
#against each video for each run 

graph6 <- ggplot(merged_video, aes(x = step_position, 
                                   y = viewed_onehundred_percent,
                                   group = as.factor(run))) +
  geom_line(aes(color = as.factor(run))) +
  geom_point(aes(color = as.factor(run))) +
  guides(color = guide_legend(title = "Run"))

#change color schemes
graph6 + scale_color_manual(values = c("#C4961A", "#F4EDCA", "#D16103", 
                              "#C3D7A4", "#52854C"))

#plot the percentage of viewed one hundred percent (complete) 
#against each video for each run 

graph7 <- ggplot(merged_video, aes(x = step_position, 
                                   y = total_views,
                                   group = as.factor(run))) +
  geom_line(aes(color = as.factor(run))) +
  geom_point(aes(color = as.factor(run))) +
  guides(color = guide_legend(title = "Run"))

#change color schemes
graph7 + scale_color_manual(values = c("#C4961A", "#F4EDCA", "#D16103", 
                                       "#C3D7A4", "#52854C"))