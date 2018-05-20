#Goal: Construct Plot 2 Global_Active_Power vs Time
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

#3rd Step: Plot2
time <- strptime(paste(consumption$Date, consumption$Time), format = "%d/%m/%Y %H:%M:%S")
png(file = "plot2.png", width = 480, height = 480)
plot(time, consumption$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)")
dev.off()
