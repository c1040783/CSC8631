#read file archetype survey responses run 1 to 7 and store it in variable
files = list.files(path = "data/", 
                   pattern="*leaving-survey-responses.csv"
                   , full.names = T)

for (i in 1:length(files)) {
  temp <- paste("leaving", i, sep = "")
  assign(temp, read.csv(files[i]))
}


