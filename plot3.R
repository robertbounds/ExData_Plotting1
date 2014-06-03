plot3 <- function() {
        
        ## read.csv2() reads csv files where "," is a ";"
        ## (which is the case for this data)
        
        ## after some exploration, the first index for 
        ## 1 Feb 2007 was found to be 66637.
        
        ## using the fact that R begins counting at 1,
        ## and also that in 2 days there are
        ##
        ##             mins      hours
        ## 2 days * 60 ---- * 24 ----- = 2880 mins ,
        ##             hour       day
        ##
        ## we can greatly reduce the number of lines to be read.
        
        energyData <- read.csv2("household_power_consumption.txt",
                                colClasses = "character",
                                nrows = 2880, skip = 66636)
        
        subMeter1 <- as.numeric(energyData[[7]])
        subMeter2 <- as.numeric(energyData[[8]])
        subMeter3 <- as.numeric(energyData[[9]])
        
        days <- c("Thu", "Fri", "Sat")
        dayIndeces <- c(1, 1440, 2880)
        
        png(file = "plot3.png",
            width = 480,
            height = 480)
        
        ## generate plot, initialize w/ Sub_meter_1 line data,
        ## blank x-axis and no label,
        ## and specified y-axis label
        plot(subMeter1, xaxt = "n", xlab = "",
             ylab = "Energy sub metering", type = "l")
        
        lines(subMeter2, col = "red")  # annotate plot w/ Sub_meter_2 line data
        lines(subMeter3, col = "blue") # annotate plot w/ Sub_meter_3 line data
        
        axis(1, at = dayIndeces, labels = days)
        
        legend("topright",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, col = c("black", "red", "blue"))


        dev.off()
}