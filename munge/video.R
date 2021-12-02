#read file video stats run 3 to 7 and store it in variable
files = list.files(path = "data/", 
                   pattern="*video-stats.csv"
                   , full.names = T)

#the range start from 3 since run 1 and 2 does not provide the video stats
for (i in 3:7) {
  temp <- paste("video", i, sep = "")
  assign(temp, read.csv(files[i-2]))
}