### This file, plot4.R, contains five functions:
###     (1) GAPplot;
###     (2) voltPlot;
###     (3) subMeterPlot;
###     (4) GRPplot;
###     (5) plot4.
###
### functions (1)-(4):
###     take required input parameters
###     (data, dayVec, and DayIndexVec)
###     to accordingly subset data, and create
###     the requested graph.

GAPplot <- function(data, dayVec, dayIndexVec) {
        ## GAPplot creates the line graph associated
        ## with global active power data
	
        globalActivePower <- as.numeric(data[[3]])
        
        plot(globalActivePower,
             xaxt = "n",
             xlab = "",
             ylab = "Global Active Power",
             type = "l"
             )
        
        axis(1, at = dayIndexVec, labels = dayVec)
}

voltPlot <- function(data, dayVec, dayIndexVec) {
        ## voltPlot creates the line graph associated with voltage data
		
	voltage <- as.numeric(data[[5]])
	
	plot(voltage, 
             xaxt = "n", 
             xlab = "datetime",
             ylab = "Voltage", 
             type = "l"
             )
        
        axis(1, at = dayIndexVec, labels = dayVec)
}

subMeterPlot <- function(data, dayVec, dayIndexVec) {
        ## subMeterPlot creates the layered line graph associated
        ## with the sub metering data subsets
		
	subMeter1 <- as.numeric(data[[7]])
        subMeter2 <- as.numeric(data[[8]])
        subMeter3 <- as.numeric(data[[9]])
        
        plot(subMeter1, 
             xaxt = "n", 
             xlab = "",
             ylab = "Energy sub metering", 
             type = "l"
             )
        
        lines(subMeter2, col = "red")
        lines(subMeter3, col = "blue")
        axis(1, at = dayIndexVec, labels = dayVec)
        legend("topright",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1,
               col = c("black", "red", "blue"),
               bty = "n"
               )
}

GRPplot <- function(data, dayVec, dayIndexVec) {
        ## GRPplot creates the line graph associated
        ## with the global reactive power data
	
	globalReactivePower <- as.numeric(data[[4]])
	
	plot(globalReactivePower,
             xaxt = "n", 
             xlab = "datetime",
             ylab = "Global_reactive_power",
             type = "l")
        
        axis(1, at = dayIndexVec, labels = dayVec)
}

plot4 <- function() {
        ## the plot4 function is tasked with reading in the
        ## necessary information from the data table,
        ## opening a png editor, and then calling each of
        ## the four screen plotting functions to write their
        ## images to the opened png file.
	
        energyData <- read.csv2("household_power_consumption.txt",
                                colClasses = "character",
                                nrows = 2880, 
                                skip = 66636
                                )
        days       <- c("Thu", "Fri", "Sat")
        dayIndeces <- c(1, 1440, 2880)
        
        png(file = "plot4.png", width = 480, height = 480)
        	
	par(mfrow = c(2, 2))
        
        ## plotting functions called in  this sequence 
        ## to fill the 2x2 frame as required by the assignment.
        GAPplot(energyData, days, dayIndeces)
        voltPlot(energyData, days, dayIndeces)
        subMeterPlot(energyData, days, dayIndeces)
        GRPplot(energyData, days, dayIndeces)
        
        dev.off()
}