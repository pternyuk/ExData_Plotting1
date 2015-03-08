plot4 <- function() {
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
  png("plot4.png", width = 480, height = 480, bg = "white")
  
  # Create layout for plots with 2 rows and 2 columns
  par(mfrow = c(2, 2))
  
  # Create plots
  with(power_data, plot(Date_time, Global_active_power, 
                        type = "l", 
                        xlab = "", 
                        ylab = "Global Active Power"))
  
  with(power_data, plot(Date_time, Voltage, 
                        type = "l", 
                        xlab = "datetime", 
                        ylab = "Voltage"))
  
  with(power_data, {
    plot(Date_time, Sub_metering_1, 
         type = "n", 
         xlab = "", 
         ylab = "Energy sub meeting")
    points(Date_time, Sub_metering_1, type = "l", col = "black")
    points(Date_time, Sub_metering_2, type = "l", col = "red")
    points(Date_time, Sub_metering_3, type = "l", col = "blue")
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"),
           lty = c(1, 1, 1),
           bty = "n")
  })
  
  with(power_data, plot(Date_time, Global_reactive_power, 
                        type = "l", 
                        xlab = "datetime", 
                        ylab = "Global_reactive_power"))
  
  # Close file device (invisible() - do not return result
  # of the invocation to console)
  invisible(dev.off())
}