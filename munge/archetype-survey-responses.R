#read file archetype survey responses run 1 to 7 and store it in variable
files = list.files(path = "data/", 
                   pattern="*archetype-survey-responses.csv"
                   , full.names = T)

for (i in 1:length(files)) {
  temp <- paste("archtype", i, sep = "")
  assign(temp, read.csv(files[i]))
}

