#merge the enrolments and leaving data based on learner id
#skip run 1 to 3 since it is empty
leaving4 <- merge(leaving4, enrolments4, by = "learner_id")
leaving5 <- merge(leaving5, enrolments5, by = "learner_id")
leaving6 <- merge(leaving6, enrolments6, by = "learner_id")
leaving7 <- merge(leaving7, enrolments7, by = "learner_id")

#drop unused columns and relocate enrolled_at to before left_at
leaving4 <- leaving4[-c(5:8, 10:20)]; leaving4 <- leaving4[, c(1,2,5,3,4)]
leaving5 <- leaving5[-c(5:8, 10:20)]; leaving5 <- leaving5[, c(1,2,5,3,4)]
leaving6 <- leaving6[-c(5:8, 10:20)]; leaving6 <- leaving6[, c(1,2,5,3,4)]
leaving7 <- leaving7[-c(5:8, 10:20)]; leaving7 <- leaving7[, c(1,2,5,3,4)]

#function to convert the date from string to date format (enrolled_at,
#left_at)

convert1 <- function(leaving){
  leaving$enrolled_at <- 
    sapply(leaving$enrolled_at, function(x) strsplit(x, split = " ")[[1]][1]) %>%
    as.Date(as.character(leaving$enrolled_at), format = "%Y-%m-%d") 
  return(leaving$enrolled_at)
}

convert2 <- function(leaving){
  leaving$left_at <- 
    sapply(leaving$left_at, function(x) strsplit(x, split = " ")[[1]][1]) %>%
    as.Date(as.character(leaving$left_at), format = "%Y-%m-%d")
  return(leaving$left_at)
}

#function to get the duration between start of enrolment and 
#leaving date
duration <- function(leaving){
  leaving$duration = difftime(leaving$left_at, leaving$enrolled_at,
                                    units = c("days"))
  return(leaving$duration)
}

#call the function for each run to convert enrolled_at + left_at
#and to get the duration
leaving4$enrolled_at <- convert1(leaving4); leaving4$left_at <- convert2(leaving4); leaving4$duration <- duration(leaving4)
leaving5$enrolled_at <- convert1(leaving5); leaving5$left_at <- convert2(leaving5); leaving5$duration <- duration(leaving5)
leaving6$enrolled_at <- convert1(leaving6); leaving6$left_at <- convert2(leaving6); leaving6$duration <- duration(leaving6)
leaving7$enrolled_at <- convert1(leaving7); leaving7$left_at <- convert2(leaving7); leaving7$duration <- duration(leaving7)

#how many person leaves each run
leaving_num = c(1:4) 
#get the percentage of students who fully participated in the course
leaving_num[1] = dim(leaving4)[1]/dim(enrolments4)[1] * 100
leaving_num[2] = dim(leaving5)[1]/dim(enrolments5)[1] * 100
leaving_num[3] = dim(leaving6)[1]/dim(enrolments6)[1] * 100
leaving_num[4] = dim(leaving7)[1]/dim(enrolments7)[1] * 100

#index and bind the data to enable easier graphing 
leaving4['run'] <- 4; leaving5['run'] <- 5; 
leaving6['run'] <- 6; leaving7['run'] <- 7

merged_leaving <- do.call("rbind", list(leaving4, leaving5, leaving6, 
                                        leaving7))

#quantify leaving reason for easier graphing
merged_leaving <- merged_leaving %>%
  group_by(leaving_reason) %>%
  mutate(reason_num = cur_group_id())

#create gg plot
graph3 <- ggplot(data = merged_leaving, aes(
  x = left_at, y = duration, color = as.factor(run))) +
  xlab("Leaving date") + ylab("Duration before leaving (days)") + 
  geom_point() +
  guides(color = guide_legend(title = "Run")) + 
  scale_x_date(date_breaks = "3 months" , date_labels = "%b-%y")

#change color schemes
graph3 + scale_color_manual(c("#C4961A", "#F4EDCA", "#D16103", "#C3D7A4", 
                              "#52854C", "#4E84C4", "#293352"))

#plot the percentage of leaving rate against each run 
graph4 <- qplot(4:7, leaving_num, colour = I("blue"))
#plot the duration before leaving against the starting date for all of the run 

#plot the compilation results of why students leave the course
graph5 <- ggplot(data.frame(merged_leaving), aes(x = reason_num)) +
  geom_bar() +
  scale_x_continuous(breaks = c(1:8))
