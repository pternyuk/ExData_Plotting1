plot2 <- function() {
  # create directory (if it does not exise), download and unzip file in this directory
  if(!file.exists("./data")) {
    dir.create("./data")
  }
  if(!file.exists("./data/household_power_consumption.txt")) {
    library(downloader)
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
  
  # Add new column to data frame with date and time
  date_time <- paste(as.character(power_data$Date), power_data$Time)
  date_time <- strptime(date_time, "%Y-%m-%d %H:%M:%S", tz = "GMT")
  power_data$Date_time <- date_time
  
  # Open file device (PNG)
  png("plot2.png", width = 480, height = 480, bg = "white")
  
  # Create plot
  with(power_data, plot(Date_time, Global_active_power, 
                        type = "l", 
                        xlab = "", 
                        ylab = "Global Active Power (kilowatts)"))
  
  # Close file device (invisible() - do not return result
  # of the invocation to console)
  invisible(dev.off())
}