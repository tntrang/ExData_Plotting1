#Goal: Construct Plot 1 "Histogram of Global Active Power (kilowatts)
#download and unzip the file mannually
#note: only be using data from the dates 2007-02-01 and 2007-02-02

library(data.table)
#1st Step: read the date column to identify the index for the dates 2007-02-01 and 2007-02-02
date <- fread("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"",
              dec = ".", fill = TRUE, select = 1)
start <- grep("^1/2/2007", date$Date)
index1 <- head(start, n =1) #start index of 2007-01-02
end <- grep("^2/2/2007", date$Date)
index2 <- tail(end, n=1) #end index of 2007-02-02

nrowread <- index2 - index1 + 1

#2nd Step: read the data file only be using data from the dates 2007-02-01 and 2007-02-02
consumption <- fread("household_power_consumption.txt", header = FALSE, sep = ";", quote = "\"",
                     dec = ".", fill = TRUE, nrows = nrowread, skip = index1, stringsAsFactors = FALSE, na.strings = "?" )
names.table <- fread("household_power_consumption.txt", header = FALSE, sep = ";", quote = "\"",
                                  dec = ".", fill = TRUE, nrows = 1, colClasses = "character")
names.chac <- as.character(names.table[1,])
names(consumption) <- names.chac

#Plot1
png(file = "plot1.png", width = 480, height = 480)
hist(consumption$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")
dev.off()