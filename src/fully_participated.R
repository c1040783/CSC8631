#subset the students who fully participated the course during  the 7 run

subset_enrolments <- function(enrolments) {
  enrolments <- enrolments[!enrolments$fully_participated_at == "" , ]
  return (enrolments)
}

enrolments1_na <- subset_enrolments(enrolments1)
enrolments2_na <- subset_enrolments(enrolments2)
enrolments3_na <- subset_enrolments(enrolments3)
enrolments4_na <- subset_enrolments(enrolments4)
enrolments5_na <- subset_enrolments(enrolments5)
enrolments6_na <- subset_enrolments(enrolments6)
enrolments7_na <- subset_enrolments(enrolments7)

#duration of the course

#function to convert the date from string to date format (enrolled at,
# fully participated at)

convert1 <- function(enrolments_na){
  enrolments_na$enrolled_at <- 
    sapply(enrolments_na$enrolled_at, function(x) strsplit(x, split = " ")[[1]][1]) %>%
    as.Date(as.character(enrolments_na$enrolled_at), format = "%Y-%m-%d") 
  return(enrolments_na$enrolled_at)
}

convert2 <- function(enrolments_na){
  enrolments_na$fully_participated_at <- 
    sapply(enrolments_na$fully_participated_at, function(x) strsplit(x, split = " ")[[1]][1]) %>%
    as.Date(as.character(enrolments_na$fully_participated_at), format = "%Y-%m-%d")
  return(enrolments_na$fully_participated_at)
}

#function to get the duration between start of enrolment and 
#fully participated date

duration <- function(enrolments_na){
  enrolments_na$duration = difftime(enrolments_na$fully_participated_at,
                                    enrolments_na$enrolled_at,
                                    units = c("days"))
  return(enrolments_na$duration)
}

#call the function for each run
enrolments1_na$enrolled_at <- convert1(enrolments1_na); enrolments1_na$fully_participated_at <- convert2(enrolments1_na); enrolments1_na$duration <- duration(enrolments1_na)
enrolments2_na$enrolled_at <- convert1(enrolments2_na); enrolments2_na$fully_participated_at <- convert2(enrolments2_na); enrolments2_na$duration <- duration(enrolments2_na)
enrolments3_na$enrolled_at <- convert1(enrolments3_na); enrolments3_na$fully_participated_at <- convert2(enrolments3_na); enrolments3_na$duration <- duration(enrolments3_na)
enrolments4_na$enrolled_at <- convert1(enrolments4_na); enrolments4_na$fully_participated_at <- convert2(enrolments4_na); enrolments4_na$duration <- duration(enrolments4_na)
enrolments5_na$enrolled_at <- convert1(enrolments5_na); enrolments5_na$fully_participated_at <- convert2(enrolments5_na); enrolments5_na$duration <- duration(enrolments5_na)
enrolments6_na$enrolled_at <- convert1(enrolments6_na); enrolments6_na$fully_participated_at <- convert2(enrolments6_na); enrolments6_na$duration <- duration(enrolments6_na)
enrolments7_na$enrolled_at <- convert1(enrolments7_na); enrolments7_na$fully_participated_at <- convert2(enrolments7_na); enrolments7_na$duration <- duration(enrolments7_na)

#removing outliers where duration days > 365
enrolments1_na <- enrolments1_na[!(enrolments1_na$duration > 365) , ]
enrolments2_na <- enrolments2_na[!(enrolments2_na$duration > 365) , ]
enrolments3_na <- enrolments3_na[!(enrolments3_na$duration > 365) , ]
enrolments4_na <- enrolments4_na[!(enrolments4_na$duration > 365) , ]
enrolments5_na <- enrolments5_na[!(enrolments5_na$duration > 365) , ]
enrolments6_na <- enrolments6_na[!(enrolments6_na$duration > 365) , ]
enrolments7_na <- enrolments7_na[!(enrolments7_na$duration > 365) , ]

#completion rate
enrolments_completion_rate = c(1:7) 
#get the percentage of students who fully participated in the course
enrolments_completion_rate[1] = dim(enrolments1_na)[1]/dim(enrolments1)[1] * 100
enrolments_completion_rate[2] = dim(enrolments2_na)[1]/dim(enrolments2)[1] * 100
enrolments_completion_rate[3] = dim(enrolments3_na)[1]/dim(enrolments3)[1] * 100
enrolments_completion_rate[4] = dim(enrolments4_na)[1]/dim(enrolments4)[1] * 100
enrolments_completion_rate[5] = dim(enrolments5_na)[1]/dim(enrolments5)[1] * 100
enrolments_completion_rate[6] = dim(enrolments6_na)[1]/dim(enrolments6)[1] * 100
enrolments_completion_rate[7] = dim(enrolments7_na)[1]/dim(enrolments7)[1] * 100

#index and bind the data to enable easier graphing 
enrolments1_na['run'] <- 1; enrolments2_na['run'] <- 2
enrolments3_na['run'] <- 3; enrolments4_na['run'] <- 4
enrolments5_na['run'] <- 5; enrolments6_na['run'] <- 6
enrolments7_na['run'] <- 7

merged_enrolments <- do.call("rbind", list(enrolments1_na, enrolments2_na, enrolments3_na,
                      enrolments4_na, enrolments5_na, enrolments6_na,
                      enrolments7_na))

#convert the duration of difftime class to integer 
merged_enrolments$duration <- as.numeric(merged_enrolments$duration, units="days")

#plot the duration against the starting date for all of the run 

#create gg plot
graph1 <- ggplot(data = merged_enrolments, aes(
  x = enrolled_at, y = duration, color = as.factor(run))) +
  xlab("Enrolled date") + ylab("Duration of completion (days)") + 
  geom_point() +
  guides(color = guide_legend(title = "Run")) + 
  scale_x_date(date_breaks = "3 months" , date_labels = "%b-%y")

#change color schemes
graph1 + scale_color_manual(c("#C4961A", "#F4EDCA", "#D16103", "#C3D7A4", 
                       "#52854C", "#4E84C4", "#293352"))

#plot the percentage of completing rate against each run 
graph2 <- qplot(1:7, enrolments_completion_rate, colour = I("blue"))