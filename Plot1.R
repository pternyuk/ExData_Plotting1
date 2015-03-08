plot1 <- function() {
  library(downloader)
  # Create directiry for data if it daes not exist
  if(!file.exists("./data")) {
    dir.create("./data")
  }
  # Download file and unzip it
  if(!file.exists("./data/household_power_consumption.txt")) {
    download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
             "data/household_power_consumption.zip")
    unzip("data/household_power_consumption.zip", exdir = "./data")
  }
  
  # Read file and convert data to corresponding types
  power_data <- read.csv("./data/household_power_consumption.txt", 
                         stringsAsFactors = FALSE, sep = ";", 
                         na.strings = "?")
  power_data <- power_data[complete.cases(power_data), ]
  power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%Y")
  power_data <- power_data[power_data$Date %in% c(as.Date("2007-02-01"), 
                                                  as.Date("2007-02-02")), ]
  
  # Open file device (PNG)
  png("plot1.png", width = 480, height = 480, bg = "white")
  
  # Create plot
  with(power_data, hist(Global_active_power, 
                        main = "Global Active Power",
                        xlab = "Global Active Power (kilowatts)", 
                        ylab = "Frequency", 
                        col = "red"))
  # Close file device (invisible() - do not return result
  # of the invocation to console)
  invisible(dev.off())
}